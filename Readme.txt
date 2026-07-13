FINNISH BY EAR — JSON LESSON GENERATION GUIDE
For use with any AI assistant (GPT, Gemini, Grok, Claude, etc.)
═══════════════════════════════════════════════════════════════

You are generating lesson JSON for a Finnish language learning app
called "Finnish by Ear" that uses the Paul Noble method. The output
must be a single valid JSON object. This guide explains every
available block type, the annotation syntax, and gives full examples.
Study this carefully before generating any lesson.

───────────────────────────────────────────────────────────────
SECTION 1 — TOP-LEVEL LESSON STRUCTURE
───────────────────────────────────────────────────────────────

Every lesson is a JSON object with these fields:

{
  "id": "l9",
  "number": 9,
  "title": "The Finnish phrase (or topic title)",
  "subtitle": "English translation or description",
  "tags": ["array", "of", "topic", "tags"],
  "blocks": [ ...array of block objects... ]
}

Rules:
- id must be unique. Use "l" followed by the lesson number: "l9", "l10" etc.
- number is an integer.
- title should be a real Finnish phrase the learner encountered, or a
  topic label if the lesson covers a theme (e.g. "Pohjois-Karjalaan",
  "Energiasyöppö vai maineteko?").
- subtitle is the English translation or a short English description.
- tags are lowercase strings. Good tags: "basics", "questions",
  "café", "grammar", "idioms", "song", "reading", "culture",
  "past tense", "conditional", "cases", "B1", "real-life", "personal".
- blocks is an array of block objects explained below.

───────────────────────────────────────────────────────────────
SECTION 2 — THE ANNOTATION SYNTAX (most important feature)
───────────────────────────────────────────────────────────────

Inside certain text fields, you can annotate individual words or
phrases using this syntax:

  {word|colorType|label|meaning}

This renders the word as a colored chip with a label badge above it,
and shows a note below the sentence with the meaning.

The four parts:
  word      = the Finnish word or phrase being annotated
  colorType = one of six types (see below)
  label     = a short grammatical or functional label
  meaning   = the English meaning of that word

THE SIX COLOR TYPES:
  word      = amber/gold    — vocabulary, nouns, adjectives, adverbs
  grammar   = teal          — verbs, verb forms, cases, grammatical structures
  phrase    = green         — whole phrases, idioms used as units
  culture   = pink/rose     — cultural references, register notes
  tip       = purple        — Tips, learning insights
  pronun    = orange        — pronunciation notes embedded in text

GOOD ANNOTATION EXAMPLES:

  "{Voisin|grammar|conditional|I'd like} {ottaa|word|verb|to take} kahvin."
  Renders: "Voisin" in teal (grammar), "ottaa" in amber (word)
  Notes below: voisin = I'd like | ottaa = to take

  "{Matkaan|word|illative|into the journey} on {mahtunut|grammar|perfect passive|has fitted}."
  
  "{Eihän|grammar|emphatic neg.|well it didn't} elämä {paljoa|word|partitive|much} antanut."

  "{Yhteisöllisyys|phrase|compound noun|community spirit} {näkyy|word|verb|shows} hyvin."

ANNOTATION RULES:
- Only annotate the words you want to teach. Do not annotate every word.
- One annotation per key word is enough. Do not double-annotate.
- The label should be short (1-3 words): verb, noun, past tense,
  conditional, illative, partitive, compound noun, Q-word, pronoun etc.
- The meaning should be concise English: "I wanted", "to go", "from where"
- Plain text around annotations is fine. Mix freely.
- Annotations work in these block types: phrase (annotated field),
  text (content field), examples (fi field), dialogue (fi field).

───────────────────────────────────────────────────────────────
SECTION 3 — ALL BLOCK TYPES WITH FULL EXAMPLES
───────────────────────────────────────────────────────────────

BLOCK TYPE 1: intro
───────────────────
A plain opening paragraph. Used once at the start of the lesson.
Sets the scene, tells the learner what they will learn and why.
No annotation syntax. Just text.

  {
    "type": "intro",
    "text": "You heard this at a Finnish café. It sounds long and
    complicated — but it is three clean pieces snapped together.
    By the end of this lesson you will be ordering anything in
    any Finnish café, politely, like a local."
  }

Do: write naturally, conversationally, like a teacher talking.
Do: reference where the learner heard the phrase if known.
Do not: use bullet points or headers inside the text field.


BLOCK TYPE 2: heading
─────────────────────
A section heading that divides the lesson into parts. Use to mark
new topics, new grammar sections, or turning points in the lesson.
No annotation syntax.

  {
    "type": "heading",
    "text": "The magic word: on"
  }

  {
    "type": "heading",
    "text": "Piece 2 — Ottaa: to take / to order"
  }

Do: use headings to break long lessons into digestible sections.
Do: make headings specific, not generic ("The -isi conditional"
    is better than "Grammar section").


BLOCK TYPE 3: text
──────────────────
A paragraph of explanatory prose. Supports annotation syntax in
the "content" field.

  {
    "type": "text",
    "content": "To say from a place, add {-stä|grammar|suffix|from}
    or {-sta|grammar|suffix|from} to the city name. Use -stä after
    front vowels (ä ö y) and -sta after back vowels (a o u).
    Finnish is completely consistent about this — it is called
    vowel harmony."
  }

  {
    "type": "text",
    "content": "{On|grammar|verb|is} means 'is.' That is it.
    Finnish stacks words simply — no word order tricks to learn yet."
  }

Do: use for grammar explanations, cultural notes embedded in prose,
    or bridging context between blocks.
Do: annotate the key word being explained inline in the text.
Do not: write more than 4-5 sentences in one text block.
    Split into multiple blocks with headings between them.


BLOCK TYPE 4: phrase
─────────────────────
The hero block. Displays a Finnish phrase large and prominently,
with full annotation and an English translation below.
Use this for the main phrase of the lesson or key sentences.

  {
    "type": "phrase",
    "annotated": "{Voisin|grammar|conditional|I'd like} {ottaa|word|verb|to take/order} vanilla latte {mukaan|word|adverb|to go}.",
    "translation": "I'd like a vanilla latte to go."
  }

  {
    "type": "phrase",
    "annotated": "{Mistä|grammar|from-where|from where} {sä|word|pronoun|you} {oot|grammar|verb|are}?",
    "translation": "Where are you from?"
  }

Do: annotate every significant word in the annotated field.
Do: include the translation field always.
Do: use for the phrase the learner heard in real life.
Do not: use for very long sentences — break those into examples blocks.


BLOCK TYPE 5: examples
────────────────────────
A list of example sentences. Each item has a Finnish sentence (fi)
and an English translation (en). The fi field supports annotations.
Use to show a pattern across multiple sentences.

  {
    "type": "examples",
    "items": [
      {
        "fi": "Voisin {ottaa|word|verb|take/order} kahvin.",
        "en": "I'd like a coffee."
      },
      {
        "fi": "Voisin {ottaa|word|verb|take/order} teen.",
        "en": "I'd like a tea."
      },
      {
        "fi": "Voisin {ottaa|word|verb|take/order} veden.",
        "en": "I'd like a water."
      }
    ]
  }

Do: use 3-5 items per examples block.
Do: vary the examples to show the range of a pattern.
Do: annotate the key changing word consistently across items.
Do: put English in the en field — clean, natural English.
Do not: annotate every word — just the teaching target.


BLOCK TYPE 6: dialogue
────────────────────────
A conversational exchange between two or more speakers.
Speakers are labeled A, B, C. Each line has fi and en fields.
The fi field supports annotations.
Use to show how the lesson's language works in real conversation.

  {
    "type": "dialogue",
    "lines": [
      {
        "speaker": "A",
        "fi": "Hei! Mitä saisi olla?",
        "en": "Hi! What can I get you?"
      },
      {
        "speaker": "B",
        "fi": "Hei! Voisin ottaa vanilla latte mukaan.",
        "en": "Hi! I'd like a vanilla latte to go."
      },
      {
        "speaker": "A",
        "fi": "Mikä koko?",
        "en": "What size?"
      },
      {
        "speaker": "B",
        "fi": "Iso, kiitos.",
        "en": "Large, please."
      }
    ]
  }

Do: make dialogues feel natural and real — not textbook stiff.
Do: include only words the learner can plausibly understand or learn.
Do: use A and B for two speakers, add C for three.
Do: keep dialogues to 4-8 lines. Split into multiple dialogues
    if the exchange is longer.
Do not: annotate every word in dialogue — keep it clean and readable.
    Annotate only the lesson's key teaching word if needed.


BLOCK TYPE 7: note
───────────────────
A colored callout box. Used for grammar insights, cultural notes,
tips, pronunciation comments, or anything worth
highlighting separately from the main flow.

Fields:
  color = one of: word, grammar, phrase, culture, tip, pronun
  title = short bold label at the top (optional but recommended)
  text  = the note content (plain text, no annotation syntax)

  {
    "type": "note",
    "color": "grammar",
    "title": "Pattern recognition",
    "text": "From Lesson 1 you know: [thing] + on + [thing].
    Now: Mun nimi + on + Pekka. You already knew how to build
    this sentence. You just needed the new words."
  }

  {
    "type": "note",
    "color": "culture",
    "title": "Kalja — Finnish beer, Finnish soul",
    "text": "Olut is the formal word for beer. Kalja is the warm
    colloquial version — the beer you drink at a lake, at a
    relative's porch, or until sunrise in North Karelia."
  }

  {
    "type": "note",
    "color": "tip",
    "title": "Rule",
    "text": "Finnish has no 'a' or 'the.' Never mourn what a
    language lacks. Move on."
  }

COLOR GUIDE FOR NOTES:
  grammar  = teal box  — use for grammar explanations and patterns
  culture  = pink box  — use for cultural context, register, real-life use
  tip      = purple box — use for insights, learner tips
  word     = amber box — use for word etymology, compound word breakdowns
  phrase   = green box — use for phrase-level insights, idiom explanations
  pronun   = orange box — use for pronunciation rules embedded in lesson flow

Do: use notes generously — they are the heart of the method.
Do: make the title punchy and specific.
Do: write note text in second person ("you") addressing the learner.
Do not: put annotation syntax inside note text fields.
Do not: make notes longer than 5-6 sentences. Split if needed.


BLOCK TYPE 8: vocab
─────────────────────
A vocabulary table with Finnish, English, and type columns.
Use at or near the end of a lesson to consolidate all new words.

Fields per row:
  fi   = Finnish word or phrase
  en   = English translation
  type = one of: word, grammar, phrase, pronun

  {
    "type": "vocab",
    "rows": [
      { "fi": "voisin",   "en": "I'd like (conditional)",   "type": "grammar" },
      { "fi": "ottaa",    "en": "to take / to order",       "type": "word" },
      { "fi": "mukaan",   "en": "to go / along",            "type": "word" },
      { "fi": "kiitos",   "en": "thank you",                "type": "phrase" },
      { "fi": "iso",      "en": "large / big",              "type": "word" },
      { "fi": "mikä koko?", "en": "what size?",             "type": "phrase" }
    ]
  }

TYPE GUIDE FOR VOCAB:
  word    = nouns, adjectives, adverbs, free-standing content words
  grammar = verbs, verb forms, case endings, particles, conjunctions
  phrase  = multi-word units, idioms, set expressions
  pronun  = pronunciation-specific entries (rare in vocab tables)

Do: include every new word from the lesson.
Do: use the fi field for the base form (infinitive for verbs).
Do: note the grammatical category briefly in the en field
    e.g. "I wanted (past of haluta)" or "from where (question word)".
Do: order from most important / most reusable to least.


BLOCK TYPE 9: comparison
─────────────────────────
A table for comparing sets of related items — colloquial vs formal,
case endings across a paradigm, or parallel structures.

Fields:
  headers = array of column header strings
  rows    = array of arrays (each inner array is one row)

  {
    "type": "comparison",
    "headers": ["Colloquial", "Formal/Textbook", "English"],
    "rows": [
      ["mä",   "minä",  "I"],
      ["mun",  "minun", "my"],
      ["sun",  "sinun", "your"],
      ["oon",  "olen",  "I am"],
      ["oot",  "olet",  "you are"]
    ]
  }

  {
    "type": "comparison",
    "headers": ["Case", "Suffix", "Meaning", "Example"],
    "rows": [
      ["Inessive",  "-ssa/-ssä", "inside",       "kaupassa — in the shop"],
      ["Elative",   "-sta/-stä", "from inside",  "kaupasta — from the shop"],
      ["Illative",  "-an/-ään",  "into",         "kauppaan — into the shop"],
      ["Adessive",  "-lla/-llä", "at/on",        "kurssilla — at the course"],
      ["Ablative",  "-lta/-ltä", "from (surface)","kurssilta — from the course"],
      ["Allative",  "-lle",      "onto/to",      "kurssille — onto the course"]
    ]
  }

Do: use for grammar paradigms, formal/colloquial contrasts,
    and any time parallel structure aids learning.
Do: keep rows to 2-6 items. More than 6 rows is overwhelming.
Do: keep cell content short — single words or short phrases only.


BLOCK TYPE 10: checklist
─────────────────────────
A summary checklist at the end of the lesson. Shows what the
learner now owns after completing this lesson. Each item is a
short line with a green checkmark displayed next to it.

  {
    "type": "checklist",
    "title": "What you now own",
    "items": [
      "voisin ottaa — I'd like (the polite ordering formula)",
      "mukaan — to go",
      "kiitos — thank you (memorise this today)",
      "iso — large",
      "You can now order any drink or food in a Finnish café",
      "The difference between voisin (I'd like) and haluan (I want)"
    ]
  }

Do: always include a checklist at the very end of every lesson.
Do: mix vocabulary items (word — meaning) with skill statements
    ("You can now order anything in a Finnish café").
Do: write skill statements in second person.
Do: keep items to 6-10 lines.
Do: make the last item feel like a milestone — something the learner
    can actually do now in real life.


BLOCK TYPE 11: pronunciation
─────────────────────────────
A dedicated pronunciation guide block. Displayed in an orange box
with a speaker icon. For detailed pronunciation notes about the
lesson's key words.

  {
    "type": "pronunciation",
    "content": "Voisin: VOY-sin (the oi sounds like 'boy').
    Ottaa: OT-taa (double t means a brief stop; both a's are long
    and pure). Mukaan: MOO-kaan (long u, long aa — Finnish vowels
    never swallow themselves or blend into each other)."
  }

Do: use syllable breaks with hyphens: VOY-sin, OT-taa.
Do: reference English sounds the learner already knows.
Do: cover 3-5 key words per pronunciation block.
Do not: write more than 4-5 sentences. Keep it focused.


BLOCK TYPE 12: image
─────────────────────
An image block with an optional caption. In practice, the src
field will be filled by the user when they add an image via the
app's editor. When generating JSON, leave src as empty string
and provide a descriptive caption as a suggestion.

  {
    "type": "image",
    "src": "",
    "caption": "A nakkikioski — the Finnish late-night sausage
    stand where many rainbows end."
  }

Do: always write a caption even if src is empty.
Do: use image blocks sparingly — one per lesson maximum.


BLOCK TYPE 13: divider
────────────────────────
A simple horizontal dashed line to separate major sections.
No fields other than type.

  {
    "type": "divider"
  }

Use: between the main lesson content and the vocab table,
or between two very different sections.


───────────────────────────────────────────────────────────────
SECTION 4 — RECOMMENDED LESSON STRUCTURE
───────────────────────────────────────────────────────────────

A well-structured lesson follows this order:

  1. intro          — set the scene, where did learner hear this?
  2. phrase         — the hero phrase, fully annotated
  3. note (culture) — why this phrase, register, real-life context
  4. heading        — "Piece 1 / Word 1 / The key concept"
  5. text or note   — explain the first key element
  6. examples       — 3-4 examples of that element in use
  7. heading        — "Piece 2..." etc.
  8. note (grammar) — grammar pattern if relevant
  9. examples or dialogue — more practice
  10. dialogue      — a full realistic exchange using the lesson vocab
  11. note (tip)    — insight or key takeaway
  12. pronunciation — key words from the lesson
  13. divider       — visual break
  14. vocab         — full vocabulary table
  15. checklist     — "What you now own"

Not every lesson needs all of these. A song lesson (like Pohjois-
Karjalaan) organises by verse/chorus. A newspaper vocabulary lesson
organises by theme. A ceremony lesson organises by speech excerpt.
Adapt the structure to the content.

Minimum required blocks in any lesson:
  - At least one phrase or intro block
  - At least one note block
  - A vocab block
  - A checklist block at the end

───────────────────────────────────────────────────────────────
SECTION 5 — THE METHOD PRINCIPLES
───────────────────────────────────────────────────────────────

These principles govern how lessons are written. Apply them in
every lesson you generate.

1. START WITH WHAT THE LEARNER ALREADY KNOWS.
   Begin each lesson by referencing something from a previous
   lesson. "From Lesson 3 you know mistä. Now watch what happens
   when you change one letter." This creates confidence.

2. NEVER MOURN WHAT A LANGUAGE LACKS.
   If Finnish doesn't have something English has (articles, gender,
   etc.) — state it once and move on. Do not apologise for it
   or dwell on it.

3. BUILD ON PATTERNS, NOT RULES.
   Instead of "the illative case is formed by...", say "watch what
   happens: Karjala → Karjalaan, kahvi → kahviin. The -An ending
   means you're going INTO something. You've seen this before."

4. ONE THING AT A TIME.
   Each lesson has one central phrase or concept. Everything else
   serves that central idea. Do not try to teach five things at once.

5. REUSE VOCABULARY FROM EARLIER LESSONS.
   When new grammar appears, demonstrate it with words the learner
   already owns. If they know tää (this) and on (is), show the new
   pattern using those words before introducing new ones.

6. REAL LANGUAGE OVER TEXTBOOK LANGUAGE.
   Colloquial Finnish (mä, sä, oon, oot) over formal Finnish
   (minä, sinä, olen, olet) unless the lesson explicitly contrasts
   the two. The learner is learning street Finnish.

7. CULTURAL CONTEXT IS NOT OPTIONAL.
   Every lesson should contain at least one note that explains
   the cultural context of the language being taught. Language
   without culture is just code.

8. END WITH WHAT THEY CAN NOW DO.
   The checklist must include at least one sentence about what
   real-world action the learner can now perform: "You can now
   order any drink in a Finnish café" or "You can say goodbye
   in Finnish in a way that feels genuinely natural."

9. REPEAT REGULARLY IT'S OK IF YOU HAVE FORGOTTEN.
                                     
───────────────────────────────────────────────────────────────
SECTION 6 — COMPLETE MINI-LESSON EXAMPLE
───────────────────────────────────────────────────────────────

Here is a short but complete valid lesson JSON to use as a
reference. Study the structure and annotation style before
generating any lesson.

{
  "id": "l_example",
  "number": 99,
  "title": "Anteeksi, missä on vessa?",
  "subtitle": "Excuse me, where is the toilet?",
  "tags": ["basics", "questions", "real-life", "directions"],
  "blocks": [
    {
      "type": "intro",
      "text": "You are in a Finnish restaurant, a train station, or a
      shopping centre. You need the toilet. This is the sentence.
      It is short, it is polite, and after this lesson you will
      never need to mime it again."
    },
    {
      "type": "phrase",
      "annotated": "{Anteeksi|phrase|polite opener|excuse me}, {missä|grammar|Q-word|where (at)} on {vessa|word|noun|toilet (colloquial)}?",
      "translation": "Excuse me, where is the toilet?"
    },
    {
      "type": "note",
      "color": "culture",
      "title": "Vessa vs WC vs käymälä",
      "text": "Vessa is the colloquial word for toilet — warm, everyday,
      what Finns say. WC (pronounced vee-see) appears on signs. Käymälä
      is formal and appears in written Finnish. In speech, always say
      vessa. Saying käymälä in conversation would be like saying
      'lavatory' in casual English."
    },
    {
      "type": "heading",
      "text": "Anteeksi — the opener that softens everything"
    },
    {
      "type": "text",
      "content": "{Anteeksi|phrase|polite opener|excuse me} means both
      'excuse me' and 'sorry.' It is your universal politeness tool.
      Use it before any question to a stranger and you will immediately
      sound considerate rather than abrupt."
    },
    {
      "type": "examples",
      "items": [
        {
          "fi": "{Anteeksi|phrase|polite opener|excuse me}, {missä|grammar|Q-word|where} on {vessa|word|noun|toilet}?",
          "en": "Excuse me, where is the toilet?"
        },
        {
          "fi": "{Anteeksi|phrase|polite opener|excuse me}, {missä|grammar|Q-word|where} on {kahvila|word|noun|café}?",
          "en": "Excuse me, where is the café?"
        },
        {
          "fi": "{Anteeksi|phrase|polite opener|excuse me}, {missä|grammar|Q-word|where} on {lähin|word|adjective|nearest} {apteekki|word|noun|pharmacy}?",
          "en": "Excuse me, where is the nearest pharmacy?"
        }
      ]
    },
    {
      "type": "note",
      "color": "tip",
      "title": "Missä — you already own this",
      "text": "From Lesson 5 you know missä means 'where at' — a location
      where something is sitting still. Missä on vessa? — where is the
      toilet sitting? Perfect. Same word, new situation, zero new grammar."
    },
    {
      "type": "dialogue",
      "lines": [
        {
          "speaker": "A",
          "fi": "Anteeksi, missä on vessa?",
          "en": "Excuse me, where is the toilet?"
        },
        {
          "speaker": "B",
          "fi": "Se on tuolla, toisessa kerroksessa.",
          "en": "It's over there, on the second floor."
        },
        {
          "speaker": "A",
          "fi": "Kiitos paljon!",
          "en": "Thank you very much!"
        },
        {
          "speaker": "B",
          "fi": "Ole hyvä!",
          "en": "You're welcome!"
        }
      ]
    },
    {
      "type": "note",
      "color": "word",
      "title": "Free words from the dialogue",
      "text": "Se = it. Tuolla = over there. Toinen = second / other.
      Kerros = floor / storey. Toisessa kerroksessa = on the second floor
      (inessive case: -ssa = inside/on). Kiitos paljon = thank you very
      much. Ole hyvä = you are welcome (literally 'be good')."
    },
    {
      "type": "pronunciation",
      "content": "Anteeksi: AN-teek-si (three syllables, stress on first,
      long ee in the middle). Vessa: VES-sa (short e, double s).
      Missä: MIS-sä (short i, the ä is like the a in 'cat')."
    },
    {
      "type": "vocab",
      "rows": [
        { "fi": "anteeksi",  "en": "excuse me / sorry",         "type": "phrase" },
        { "fi": "missä",     "en": "where (at a place)",        "type": "grammar" },
        { "fi": "vessa",     "en": "toilet (colloquial)",       "type": "word" },
        { "fi": "tuolla",    "en": "over there",                "type": "word" },
        { "fi": "kerros",    "en": "floor / storey",            "type": "word" },
        { "fi": "kiitos paljon", "en": "thank you very much",   "type": "phrase" },
        { "fi": "ole hyvä",  "en": "you're welcome",            "type": "phrase" }
      ]
    },
    {
      "type": "checklist",
      "title": "What you now own",
      "items": [
        "anteeksi — excuse me / sorry (use it before every question to a stranger)",
        "vessa — toilet (the word Finns actually say)",
        "missä on ___? — where is ___? (swap any noun in)",
        "ole hyvä — you're welcome",
        "You can now ask for the toilet, a café, or a pharmacy in Finnish",
        "You understand why missä and not mihin (the thing is still, not moving)"
      ]
    }
  ]
}

───────────────────────────────────────────────────────────────
SECTION 7 — QUICK REFERENCE: WHAT TO ANNOTATE
───────────────────────────────────────────────────────────────

USE "word" (amber) FOR:
  nouns, adjectives, adverbs, pronouns when they are vocabulary targets
  e.g. {vessa|word|noun|toilet}, {iso|word|adjective|large},
       {mukaan|word|adverb|to go}, {tää|word|pronoun|this}

USE "grammar" (teal) FOR:
  verb forms, tense markers, case suffixes, particles, conjunctions
  e.g. {voisin|grammar|conditional|I'd like},
       {olen ollut|grammar|perfect|I have been},
       {-stä|grammar|suffix|from}, {eihän|grammar|emphatic neg.|well it didn't}

USE "phrase" (green) FOR:
  multi-word chunks treated as one unit, idioms, set expressions
  e.g. {matkaan on mahtunut|phrase|idiom|the journey has included},
       {auringon nousuun|phrase|set expression|until sunrise},
       {jonon kärjessä|phrase|idiom|at the front of the queue}

USE "culture" (pink) FOR:
  words that carry cultural weight beyond their literal meaning
  e.g. {kalja|culture|colloquial beer|warm/casual word for beer},
       {nakkikioski|culture|cultural icon|late-night sausage stand}

USE "tip" (purple) FOR:
  words that illustrate a learning tip or method insight (rare inline,
  more common in note blocks — use sparingly in annotations)

USE "pronun" (orange) FOR:
  words where the pronunciation itself is the teaching point
  e.g. {ää|pronun|vowel|like 'a' in cat but longer}

───────────────────────────────────────────────────────────────
SECTION 8 — COMMON MISTAKES TO AVOID
───────────────────────────────────────────────────────────────

1. OVER-ANNOTATING
   Bad:  "{Mä|word|pronoun|I} {oon|grammar|verb|am} {hyvä|word|adj|good}."
   Good: "Mä {oon|grammar|verb|am} hyvä." (only annotate the teaching target)

2. ANNOTATION SYNTAX ERRORS
   Bad:  {voisin|conditional|I'd like}         (only 3 parts — needs 4)
   Bad:  {voisin|grammar|I'd like}             (only 3 parts — needs 4)
   Good: {voisin|grammar|conditional|I'd like} (all 4 parts present)

3. WRONG BLOCK TYPE FOR THE CONTENT
   Bad:  Using "text" for a dialogue exchange
   Bad:  Using "note" for a vocabulary list
   Good: Use "dialogue" for exchanges, "vocab" for word lists

4. ANNOTATION SYNTAX INSIDE NOTE TEXT FIELDS
   Bad:  note text field containing {word|grammar|label|meaning}
   Good: note text is plain prose only — no annotation syntax

5. MISSING CHECKLIST
   Every lesson must end with a checklist block. It is how the
   learner knows what they have gained from the lesson.

6. FORMAL FINNISH WHEN COLLOQUIAL IS NATURAL
   Bad:  Using "minä" and "sinä" in dialogue between friends
   Good: Using "mä" and "sä" in casual dialogue
   Exception: formal speeches, official contexts, song lyrics
   where the formal form is actually used

7. FORGETTING THE CULTURAL NOTE
   Every lesson about a real phrase or real situation needs at
   least one culture-colored note explaining why Finns say it
   this way, what it signals, and when to use it.

8. ROWS IN COMPARISON TABLE NOT AS ARRAYS
   Bad:  "rows": [{"col1": "mä", "col2": "minä"}]
   Good: "rows": [["mä", "minä", "I"]]
   Each row must be a plain array of strings, not an object.

───────────────────────────────────────────────────────────────
SECTION 9 — HOW TO REQUEST A LESSON
───────────────────────────────────────────────────────────────

When asking an AI to generate a lesson, provide:

  1. A source phrase or topic
     e.g. "I heard a Finnish friend say: Mennään baariin!"
     e.g. "Generate a lesson on the Finnish past tense -si ending"
     e.g. "Make a lesson from this newspaper article extract: [text]"
     e.g. "Make a lesson from this song: [lyrics with translation]"

  2. The lesson number
     e.g. "This is lesson 9"

  3. Any context about where/how it was heard
     e.g. "Heard at a Helsinki bus stop", "from a TV show",
     "my Finnish colleague said this at work"

  4. The output format instruction
     "Output must be a single valid JSON object following the
     Finnish by Ear lesson format from this guide. Output JSON
     only — no surrounding text, no markdown code fences."

EXAMPLE PROMPT USING THIS GUIDE:

  "Using the Finnish by Ear JSON lesson format described in
  [this guide], generate lesson 9. My Finnish friend said
  'Mennään baariin!' when suggesting we go to a bar.
  This is lesson 9. Cover the verb mennä (to go), the
  -taan/-daan passive for suggestions, and the illative
  case -Vn for destinations. Output valid JSON only."

───────────────────────────────────────────────────────────────
END OF GUIDE
Version for Finnish by Ear
Lessons follow the colloquial Finnish register (mä/sä/oon/oot)
unless the source material uses formal Finnish.
───────────────────────────────────────────────────────────────
