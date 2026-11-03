# Build failure diagnosis

You are diagnosing a failed build of jakzal/phpqa — a Docker image bundling PHP
quality-assurance tools. `failed-debug.log` (attached) contains the logs of
every failed step of one GitHub Actions run. The image is built from a matrix
of OS flavours (debian, alpine) and recent PHP versions; job names look like
"Build (debian, <php-version>)". The repository — including the exact
Dockerfile used for the run — is checked out in the current directory; read it
to trace a failing install step to its tool.

Your task:

1. If the log is empty or only says "No logs available", state that the failure
   was likely runner-level and needs no analysis.
2. For EACH failed matrix job in the log, classify the root cause as exactly one
   of:
   - `broken-install`   — a tool download/install broke (404, renamed release,
                          moved binary, missing dependency, upstream changed)
   - `signature-change` — a checksum, GPG/PHAR signature, or key of a downloaded
                          artifact failed verification or was updated upstream
   - `transient`        — network hiccup, rate limit, DNS, timeout, runner
                          error; restarting the failed job may simply fix it
   - `other`            — anything else; describe it briefly
3. For each failure cite the decider evidence: quote the exact log lines (and
   for `signature-change`, the expected vs. received values). Name the affected
   tool and the involved step.
4. Suggest a concrete, minimal resolution per failure. For `transient`, say
   plainly: "Likely resolved by restarting the failed job — no code change
   needed." Otherwise reference the piece to change (Dockerfile line, toolbox
   tool, dependency) without pretending to design the change.

## Rules

- Use only the attached log and files in this repository. Do not use web
  access or fetch anything over the network.
- Do not modify, create, or delete any files.
- Quote real log lines only; never invent versions, URLs, or checksums.
- If evidence is skimpy, say so and give low confidence.
- Output is pasted verbatim into the run summary; keep it valid markdown,
  concise — a few lines per failed job.
- Per failed job, output exactly:

  **Diagnosis** (with the cause tag)
  **Evidence**
  **Suggested resolution**
  **Confidence** (high/medium/low)
