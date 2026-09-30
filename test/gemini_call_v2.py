"""
Subprocess helper: call Vertex AI Gemini with BNL ADC auth.
Supports multimodal input (PDF files and images).

Usage:
    echo "Explain XANES briefly." | python gemini_call_v2.py
    echo "Analyze this paper." | python gemini_call_v2.py --pdf paper.pdf
    echo "What is in this figure?" | python gemini_call_v2.py --images fig1.png fig2.png
"""

import os
import sys
import json
import base64
import requests
import google.auth
from google.auth.transport.requests import Request

import argparse

PROJECT_ID = "geminienterpriseprod-485218"
LOCATION = "global"
DEFAULT_MODEL = "gemini-3.1-pro-preview"


def get_access_token():
    credentials, _ = google.auth.default(
        scopes=["https://www.googleapis.com/auth/cloud-platform"]
    )
    credentials.refresh(Request())
    return credentials.token


MIME_TYPES = {
    ".pdf": "application/pdf",
    ".png": "image/png",
    ".jpg": "image/jpeg",
    ".jpeg": "image/jpeg",
    ".webp": "image/webp",
    ".gif": "image/gif",
}


def call_gemini(prompt, pdf_path=None, image_paths=None, temperature=0.1, max_tokens=65536, model=None):
    """pdf_path can be a str, list of str, or None."""
    model = model or DEFAULT_MODEL
    token = get_access_token()

    if LOCATION == "global":
        base_url = "https://aiplatform.googleapis.com/v1"
    else:
        base_url = f"https://{LOCATION}-aiplatform.googleapis.com/v1"

    url = (
        f"{base_url}"
        f"/projects/{PROJECT_ID}"
        f"/locations/{LOCATION}"
        f"/publishers/google/models/{model}"
        f":generateContent"
    )

    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/json",
    }

    parts = []
    pdf_paths = pdf_path if isinstance(pdf_path, list) else ([pdf_path] if pdf_path else [])
    for p in pdf_paths:
        with open(p, "rb") as f:
            pdf_data = base64.b64encode(f.read()).decode("utf-8")
        parts.append({
            "inline_data": {
                "mime_type": "application/pdf",
                "data": pdf_data,
            }
        })
    if image_paths:
        for img_path in image_paths:
            ext = os.path.splitext(img_path)[1].lower()
            mime = MIME_TYPES.get(ext, "image/png")
            with open(img_path, "rb") as f:
                img_data = base64.b64encode(f.read()).decode("utf-8")
            parts.append({
                "inline_data": {
                    "mime_type": mime,
                    "data": img_data,
                }
            })
    parts.append({"text": prompt})

    payload = {
        "contents": [{"role": "user", "parts": parts}],
        "generationConfig": {
            "temperature": temperature,
            "maxOutputTokens": max_tokens,
        },
    }

    response = requests.post(url, headers=headers, json=payload, timeout=600)
    response.raise_for_status()
    data = response.json()
    return data["candidates"][0]["content"]["parts"][0]["text"]


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--model", type=str, default=DEFAULT_MODEL,
                        help=f"Gemini model name (default: {DEFAULT_MODEL})")
    parser.add_argument("--pdf", type=str, action="append", default=None,
                        help="Path to PDF file(s). Use multiple times to attach multiple PDFs.")
    parser.add_argument("--images", type=str, nargs="+", default=None,
                        help="Path(s) to image files for multimodal input")
    args, _ = parser.parse_known_args()

    global MODEL
    MODEL = args.model

    prompt = sys.stdin.read().strip()
    if not prompt:
        print(json.dumps({"error": "empty prompt"}))
        sys.exit(1)

    try:
        result = call_gemini(prompt, pdf_path=args.pdf, image_paths=args.images)
        print(json.dumps({"ok": True, "text": result}))
    except Exception as e:
        print(json.dumps({"ok": False, "error": str(e)}))
        sys.exit(1)
