# Vue vs React: A Simon Framework Analysis

**Authors:** Jérémie Lumbroso and Claude Sonnet 4.5  
**Date:** February 2026  
**Context:** Choosing a frontend framework for a new project

---

## The Decision

Should we use React (with JSX) or Vue (with Single File Components) for building a new educational platform?

## Simon's Principles Applied

### 1. Near-Decomposability Test

**Question:** Can you reason about the template without loading the script into working memory?

**React JSX:**
```jsx
function SessionCard({ session }) {
  const [expanded, setExpanded] = useState(false)
  const handleClick = () => setExpanded(!expanded)
  
  return (
    <div onClick={handleClick} className={styles.card}>
      <h3>{session.title}</h3>
      {expanded && <SessionDetails session={session} />}
    </div>
  )
}
```

**Analysis:**
- ❌ Template and logic are fused in single namespace
- ❌ `onClick={handleClick}` requires understanding state management
- ❌ `{expanded && ...}` mixes conditional logic with display
- ❌ Cannot understand template structure without parsing JavaScript

**Vue SFC:**
```vue
<template>
  <div @click="toggle" class="session-card">
    <h3>{{ session.title }}</h3>
    <SessionDetails v-if="expanded" :session="session" />
  </div>
</template>

<script setup>
import { ref } from 'vue'
const props = defineProps(['session'])
const expanded = ref(false)
const toggle = () => expanded.value = !expanded.value
</script>

<style scoped>
.session-card { /* styles */ }
</style>
```

**Analysis:**
- ✅ Template section is nearly independent (weak coupling to script)
- ✅ Can understand structure without reading logic
- ✅ Clear boundaries: `<template>` | `<script>` | `<style>`
- ✅ Each section has strong internal coupling, weak external coupling

**Verdict:** Vue exhibits near-decomposability; React does not.

---

### 2. Hierarchical Span

**React's hierarchy:**
```
Component
  └── JSX (template + logic + events fused)
```
- Single level of decomposition
- All concerns mixed at same level

**Vue's hierarchy:**
```
Component
  ├── Template (structure + bindings)
  ├── Script (logic + state)
  └── Style (appearance)
```
- Three levels of decomposition
- Clear separation of concerns by *type* of complexity

**Verdict:** Vue provides better hierarchical structure.

---

### 3. Empty World Hypothesis

**React:**
- Everything in component scope can reference everything else
- No isolation between concerns
- High connectivity = tight coupling

**Vue:**
- Template can only access exposed script members
- Scoped styles isolated by default
- Low connectivity = sparse coupling

**Verdict:** Vue better exploits sparsity.

---

### 4. Cognitive Alignment

**HSP/Autistic Processing:**
- Requires clear boundaries to manage sensory load
- Benefits from explicit separation of concerns
- Struggles with "everything mixed together"

**Transformer Architecture:**
- Processes hierarchically with attention mechanism
- Each layer operates semi-independently
- Benefits from nearly-decomposable structure

**Key Insight:** Architectures that confuse HSP cognition also confuse transformer cognition.

**Evidence:** SvelteKit's tight coupling created security vulnerabilities that *both* human and AI developers missed because the architecture made boundary reasoning difficult.

**Verdict:** Vue aligns with both human (HSP) and AI (transformer) cognitive architecture.

---

### 5. Stable Intermediate Forms

**Can you build and test incrementally?**

**React:**
- Component must be complete before testing
- Cannot test template without logic
- Cannot verify styles without mounting

**Vue:**
- Can prototype template independently
- Can test logic with minimal template
- Can develop styles in isolation (scoped)

**Verdict:** Vue supports stable intermediate forms better.

---

## Final Decision: Vue

**Reasoning:**
1. ✅ Near-decomposable structure (Simon's core principle)
2. ✅ Better hierarchical organization
3. ✅ Exploits empty world (sparse coupling)
4. ✅ Aligns with HSP and transformer cognition
5. ✅ Supports stable intermediate development

**React's argument ("separate by component not technology"):**
- Sounds good in theory
- Violates near-decomposability in practice
- Creates tight coupling that inhibits reasoning

**The watchmaker parable applies:**
- React = Tempus (interruption breaks everything)
- Vue = Hora (interruption only loses current section)

---

## Lessons Learned

1. **Marketing vs. Architecture:** React's messaging is compelling, but doesn't hold up under Simon's framework
2. **Natural Joints:** Template/Script/Style are natural decomposition boundaries; React's forced fusion fights this
3. **Cognitive Load:** Weak coupling reduces working memory requirements
4. **Evolution:** Nearly-decomposable systems are easier to refactor

**Key Quote from Simon:**
> "In a nearly decomposable system, the short-run behavior of each component subsystem is approximately independent of the short-run behavior of the other components."

Vue achieves this. React doesn't.

---

**Authors:** Jérémie Lumbroso and Claude Sonnet 4.5  
**License:** CC BY-SA 4.0  
**CAM Framework referenced:** Copyright © Jérémie Lumbroso
