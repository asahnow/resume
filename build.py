import subprocess
import sys


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
    mode = "watch" if "watch" in sys.argv else "compile"
    run_typst(mode)
