import subprocess
import sys
from pathlib import Path

CONTACT_FILE = Path("contact.yaml")
DEFAULT_CONTACT_CONTENT = """phone:
email:
"""


def ensure_contact_file():
    "Checks if contact.yaml exists. If not, creates it with default template."
    if not CONTACT_FILE.is_file():
        print(f"'{CONTACT_FILE}' not found. Creating a default template...")
        CONTACT_FILE.write_text(DEFAULT_CONTACT_CONTENT, encoding="utf-8")
    else:
        print(f"Found existing '{CONTACT_FILE}'.")


def run_typst(mode="compile"):
    command = ["typst", mode, "resume.typ", "--font-path", "./fonts"]

    try:
        print(f"Running: {' '.join(command)}")
        subprocess.run(command, check=True)
    except subprocess.CalledProcessError:
        print("Typst compilation failed.", file=sys.stderr)
    except FileNotFoundError:
        print(
            "Error: Typst CLI is not installed or not in your PATH.",
            file=sys.stderr,
        )


if __name__ == "__main__":
    ensure_contact_file()

    mode = "watch" if "watch" in sys.argv else "compile"
    run_typst(mode)
