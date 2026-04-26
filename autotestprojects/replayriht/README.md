# Replayright - replay Playwright right

An [agent skill](https://agentskills.io) that lets AI coding agents automate browsers via Playwright and auto-record every action into a replayable script.

Agents struggle to write reliable e2e tests. Replayright makes it one pass, zero retries.

```
 Common agent-driven e2e scripting        |  Replayright
    :repeated write-run cycle             |      :progressive exploration and recording
                                          |
                                          |
    Explore step1                         |  Explore step1 (step auto recorded) ─┐
    Write step1                           |       ┌──────────────────────────────┘
    Run   step1 ─┐                        |       └► Explore step2 (step auto recorded) ─┐
 ┌───────────────┘                        |               ┌──────────────────────────────┘
 └► Explore step2                         |               └► Explore step3 (step auto recorded) ─┐
    Write step2                           |                       ┌──────────────────────────────┘
    Run   step1 → step2 ─┐                |                       └► Explore step4 (step auto recorded) ─┐
 ┌───────────────────────┘                |  ┌───────────────────────────────────────────────────────────┘
 └► Explore step3                         |  └► Run  step1 → step2 → step3 → step4
    Write step3                           |
    Run   step1 → step2 → step3 ─┐        |
 ┌───────────────────────────────┘        |
 └► Explore step4                         |
    Write step4                           |
    Run   step1 → step2 → step3 → step4   |
```

## Setup

Tell your agent:

```
Install the replayright skill from https://github.com/EnixCoda/replayright
```

Replayright follows the [agent skill](https://agentskills.io) standard. Works with any compatible AI coding agent.

## See It in Action

### One-shot prompt

Give your agent a single instruction and watch it work:

```
Use replayright in headed mode to write an e2e test that fills out the
form at https://httpbin.org/forms/post with test data and submits it.
```

```
Agent: I'll start replayright and open the page.
       > open https://httpbin.org/forms/post
       I can see a form with fields for customer name, telephone,
       email, pizza size, toppings, delivery time, and comments.
       > fill input[name="custname"] John Doe
       > fill input[name="custtel"] 555-1234
       > fill input[name="custemail"] john@example.com
       > click input[value="medium"]
       > click input[value="mushroom"]
       > click input[value="onion"]
       > fill input[name="delivery"] 13:00
       > fill textarea[name="comments"] Ring the doorbell
       > click text=Submit order
       Form submitted. The response shows all data was received.
       > close httpbin-form-submit
       Script saved to ~/.replayright/scripts/httpbin-form-submit.js
```

### Progressive exploration

You can also explore step by step — the script is recorded along the way:

```
You:   Use replayright to explore https://httpbin.org/forms/post

Agent: > open https://httpbin.org/forms/post
       > observe
       I can see a form with fields: Customer (text), Telephone (tel),
       E-mail (email), Pizza Size (radio: small/medium/large),
       Toppings (checkboxes: bacon/cheese/onion/mushroom),
       Delivery time (time), and Comments (textarea).

You:   Fill it out with test data and submit

Agent: > fill input[name="custname"] John Doe
       > fill input[name="custtel"] 555-1234
       > fill input[name="custemail"] john@example.com
       > click input[value="medium"]
       > click input[value="mushroom"]
       > click input[value="onion"]
       > fill input[name="delivery"] 13:00
       > fill textarea[name="comments"] Ring the doorbell
       > click text=Submit order
       Form submitted successfully.

You:   Save the script

Agent: > close httpbin-form-e2e
       Script saved to ~/.replayright/scripts/httpbin-form-e2e.js
```

## License

MIT
