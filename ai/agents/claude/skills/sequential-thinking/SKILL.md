---
name: sequential-thinking
description: Structured reasoning methodology for breaking down multi-step problems, debugging complex issues, and making architectural decisions
user-invocable: false
---

# Sequential Thinking

A structured reasoning methodology for tackling complex problems. This skill provides a systematic approach to break down problems, generate hypotheses, and arrive at well-reasoned solutions.

**Activate when:**

- Breaking down multi-step problems
- Debugging complex issues with unclear root causes
- Making architectural decisions with trade-offs
- Analyzing requirements with ambiguities
- Evaluating multiple solution approaches
- Any situation requiring careful, step-by-step reasoning

---

## The 7-Step Process

### 1. FRAME - Define the Problem

Clearly articulate what you're trying to solve:

```
[FRAME]
Problem: What is the actual problem?
Context: What background information is relevant?
Constraints: What limitations exist?
Success Criteria: How will we know when it's solved?
```

**Example:**

```
[FRAME]
Problem: CI pipeline failing intermittently on integration tests
Context: Tests pass locally, fail ~30% of time in CI
Constraints: Cannot increase CI timeout, must maintain test coverage
Success Criteria: Tests pass consistently (>99%) in CI
```

### 2. DECOMPOSE - Break Down into Sub-Problems

Split the problem into smaller, manageable pieces:

```
[DECOMPOSE]
1. Sub-problem A: [description]
2. Sub-problem B: [description]
3. Sub-problem C: [description]

Dependencies: A -> B (B depends on A)
```

**Example:**

```
[DECOMPOSE]
1. Identify which tests fail
2. Determine failure patterns (timing, order, resources)
3. Isolate root cause per failing test
4. Implement fixes
5. Verify fix in CI

Dependencies: 1 -> 2 -> 3 -> 4 -> 5 (sequential)
```

### 3. HYPOTHESIZE - Generate Possible Explanations

List potential causes or solutions with reasoning:

```
[HYPOTHESIS] H1: [hypothesis]
Reasoning: [why this might be true]
Evidence needed: [what would confirm/refute this]
[CONFIDENCE: low/medium/high]

[HYPOTHESIS] H2: [hypothesis]
...
```

**Example:**

```
[HYPOTHESIS] H1: Race condition in database setup
Reasoning: Tests share database, parallel execution may cause conflicts
Evidence needed: Check if failures correlate with parallel test runs
[CONFIDENCE: medium]

[HYPOTHESIS] H2: External service timeout
Reasoning: Tests call external APIs, CI network may be slower
Evidence needed: Check test logs for timeout errors
[CONFIDENCE: high]

[HYPOTHESIS] H3: Resource exhaustion
Reasoning: CI has limited memory/CPU compared to local
Evidence needed: Check CI resource metrics during test runs
[CONFIDENCE: low]
```

### 4. ANALYZE - Evaluate Hypotheses

Investigate each hypothesis systematically:

```
[ANALYZE] H1
Finding: [what you discovered]
Conclusion: [confirmed/refuted/inconclusive]
Next step: [if inconclusive]
```

**Example:**

```
[ANALYZE] H1 (Race condition)
Finding: Tests run sequentially in CI, not parallel
Conclusion: REFUTED - race condition unlikely

[ANALYZE] H2 (External service timeout)
Finding: Logs show 3 timeout errors in last 10 runs, all from payment_service_spec
Conclusion: CONFIRMED - external service calls timing out

[ANALYZE] H3 (Resource exhaustion)
Finding: CI metrics show adequate memory/CPU
Conclusion: REFUTED - resources sufficient
```

### 5. DECIDE - Choose the Best Approach

Based on analysis, select the solution path:

```
[DECIDE]
Selected approach: [chosen solution]
Rationale: [why this approach]
Trade-offs: [what we're accepting]
Alternatives considered: [other options and why rejected]
```

**Example:**

```
[DECIDE]
Selected approach: Mock external payment service in tests
Rationale: H2 confirmed - external timeouts cause failures
Trade-offs: Less integration coverage, but consistent CI
Alternatives considered:
- Increase timeout (rejected: masks real issues)
- Retry logic (rejected: slows tests, doesn't fix root cause)
- VCR cassettes (considered: more complex but better coverage)
```

### 6. PLAN - Create Action Steps

Define concrete implementation steps:

```
[PLAN]
1. [ ] Step 1: [action] [estimated complexity: low/medium/high]
2. [ ] Step 2: [action]
3. [ ] Step 3: [action]

Verification: [how to confirm success]
Rollback: [how to undo if needed]
```

**Example:**

```
[PLAN]
1. [ ] Create mock for PaymentService (medium)
2. [ ] Update payment_service_spec to use mock (low)
3. [ ] Add integration test tag for real API tests (low)
4. [ ] Run CI to verify (low)

Verification: 10 consecutive CI runs with 0 failures
Rollback: Revert mock, keep tagged integration tests for manual runs
```

### 7. VALIDATE - Verify Results

Confirm the solution works as expected:

```
[VALIDATE]
Test results: [pass/fail]
Metrics: [relevant measurements]
Remaining issues: [any outstanding problems]
Lessons learned: [what to remember for future]
```

---

## Reasoning Markers

Use these markers throughout your reasoning to signal important transitions:

| Marker | Meaning | When to Use |
|--------|---------|-------------|
| `[REVISION]` | Updating previous thinking | When new information changes your understanding |
| `[BRANCH]` | Exploring alternative path | When considering a different approach |
| `[HYPOTHESIS]` | Proposing an explanation | When suggesting possible causes/solutions |
| `[CONFIDENCE: X]` | Certainty level | After hypotheses (low/medium/high) |
| `[BLOCKED]` | Cannot proceed | When hitting a blocker requiring input |
| `[ASSUMPTION]` | Making an assumption | When proceeding without confirmed information |

**Example usage:**

```
[HYPOTHESIS] The slow query is due to missing index
[CONFIDENCE: medium]

Looking at the query plan... actually:

[REVISION] The index exists but isn't being used due to type mismatch
[CONFIDENCE: high]

[BRANCH] Could also be a statistics issue - checking ANALYZE timing...
```

---

## Usage Examples

### Complex Debugging

```
[FRAME]
Problem: User reports data not syncing to external system
Context: Sync worked yesterday, no code changes deployed
Constraints: Cannot access external system logs directly
Success Criteria: Data syncs successfully, understand root cause

[DECOMPOSE]
1. Verify sync job is running
2. Check for errors in our logs
3. Verify data format hasn't changed
4. Test external system connectivity
5. Check for rate limiting or quota issues

[HYPOTHESIS] H1: External system is down
[CONFIDENCE: medium]

[HYPOTHESIS] H2: Our auth token expired
[CONFIDENCE: high]

[HYPOTHESIS] H3: Data format changed on their end
[CONFIDENCE: low]

[ANALYZE] H2
Finding: Token expiry was last week, token has expired
Conclusion: CONFIRMED - token expired

[DECIDE]
Selected approach: Refresh auth token, add monitoring for expiry
Rationale: Root cause identified, need both fix and prevention
```

### Architecture Decision

```
[FRAME]
Problem: Need to add real-time notifications feature
Context: Monolith Rails app, 10k concurrent users
Constraints: Cannot introduce significant latency, budget limited
Success Criteria: Sub-second notification delivery, scalable to 50k users

[DECOMPOSE]
1. Choose notification delivery mechanism
2. Design message storage/persistence
3. Plan client integration
4. Consider failure handling

[HYPOTHESIS] H1: WebSockets with ActionCable
[CONFIDENCE: medium]
Pros: Built into Rails, simple setup
Cons: Scaling concerns, stateful connections

[HYPOTHESIS] H2: Server-Sent Events (SSE)
[CONFIDENCE: medium]
Pros: Simpler than WebSocket, HTTP-based
Cons: One-way only, connection limits

[HYPOTHESIS] H3: Polling with long-poll optimization
[CONFIDENCE: low]
Pros: Simplest, no infrastructure changes
Cons: Higher latency, more server load

[BRANCH] What about third-party service?

[HYPOTHESIS] H4: Pusher/Ably for WebSocket
[CONFIDENCE: high]
Pros: Handles scaling, proven reliability
Cons: Cost, external dependency

[DECIDE]
Selected approach: H4 - Pusher for real-time delivery
Rationale: Scaling handled by vendor, proven at our scale
Trade-offs: Monthly cost (~$99/mo at our scale), vendor dependency
```

---

## Anti-Patterns to Avoid

### Jumping to Solutions

```
# DON'T
"The tests are failing, let me add more retries"

# DO
[FRAME] Tests failing intermittently
[HYPOTHESIS] H1: Timing issue
[HYPOTHESIS] H2: Resource contention
[ANALYZE] First, let me identify which tests and check patterns...
```

### Single-Path Thinking

```
# DON'T
"We should use Redis for this"
(without considering alternatives)

# DO
[HYPOTHESIS] H1: Redis (fast, simple)
[HYPOTHESIS] H2: PostgreSQL (already have it, ACID)
[HYPOTHESIS] H3: In-memory (simplest, no infra)
[ANALYZE] Comparing based on our constraints...
```

### Unvalidated Assumptions

```
# DON'T
"The database is probably the bottleneck" [proceeds to optimize DB]

# DO
[ASSUMPTION] Database may be the bottleneck
[VALIDATE] Checking query times...
Finding: API serialization takes 80% of time, DB is 5%
[REVISION] Bottleneck is serialization, not database
```

### Skipping Validation

```
# DON'T
[DECIDE] Use caching
[PLAN] Add Redis cache
[done]

# DO
[DECIDE] Use caching
[PLAN] Add Redis cache
[VALIDATE]
- Cache hit rate: 85%
- Response time: 200ms -> 45ms
- Error rate: unchanged
Lessons: Cache invalidation needs work, but core hypothesis confirmed
```

---

## When to Use This Process

**Full 7-step process for:**

- Bugs with unclear root cause
- Architecture decisions with trade-offs
- Performance issues with multiple potential causes
- Complex feature planning
- Incident investigation

**Abbreviated process (FRAME + HYPOTHESIS + DECIDE) for:**

- Simpler decisions with clear options
- Well-understood problem domains
- Time-sensitive situations

**Skip this process for:**

- Trivial bugs with obvious fixes
- Routine tasks with established patterns
- Clear requirements with single solution path
