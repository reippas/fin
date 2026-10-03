#!/bin/bash
#
# Add a lesson to Finnish by Ear.
#
# Lessons now live as individual JSON files in the ./lessons/ folder and are
# listed in ./lessons/manifest.json. The web app (index.html) fetches the
# manifest and loads each file at runtime, so you never have to edit the HTML.
#
# Usage: ./append_lesson.sh <input.json>
#
# The input file must be a single valid JSON lesson object with a numeric
# "number" field. It is copied to ./lessons/L<number>.json and added to the
# manifest (kept ordered by lesson number).

set -euo pipefail

if [ -z "${1:-}" ]; then
  echo "Usage: ./append_lesson.sh <input.json>"
  exit 1
fi

INPUT_JSON="$1"
LESSONS_DIR="lessons"
MANIFEST="$LESSONS_DIR/manifest.json"

if [ ! -f "$INPUT_JSON" ]; then
  echo "Error: File '$INPUT_JSON' not found!"
  exit 1
fi

mkdir -p "$LESSONS_DIR"
[ -f "$MANIFEST" ] || echo "[]" > "$MANIFEST"

python3 - "$INPUT_JSON" "$LESSONS_DIR" "$MANIFEST" <<'PY'
import json, os, shutil, sys

input_json, lessons_dir, manifest_path = sys.argv[1:4]

with open(input_json, encoding="utf-8") as f:
    lesson = json.load(f)

number = lesson.get("number")
if not isinstance(number, int):
    raise SystemExit(f"Error: lesson in {input_json} has no integer 'number' field")

fname = f"L{number}.json"
dest = os.path.join(lessons_dir, fname)

# Write a normalised copy into the lessons folder.
with open(dest, "w", encoding="utf-8") as f:
    json.dump(lesson, f, ensure_ascii=False, indent=2)

with open(manifest_path, encoding="utf-8") as f:
    manifest = json.load(f)

if fname not in manifest:
    manifest.append(fname)

# Keep the manifest ordered by lesson number (L12.json -> 12).
manifest.sort(key=lambda n: int("".join(c for c in n if c.isdigit()) or 0))

with open(manifest_path, "w", encoding="utf-8") as f:
    json.dump(manifest, f, ensure_ascii=False, indent=2)

print(f"OK Added {dest} and updated {manifest_path}")
PY
