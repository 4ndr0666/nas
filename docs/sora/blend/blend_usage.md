### **Caveat/Optimization:**

* **If you want the “original face” to dominate throughout (with only the new motion from the primary),**

  * Keep the sample (top/left) influence curve high for most or all frames, not low at the start.
  * The more the curve is “up” near the middle and end, the more the original face will persist.
  * Pulling both points “down” might be reducing the face transfer, so if you notice *not enough* of the original face, try raising the sample curve, especially in the region where the face is most visible.

* **If you want the face to “fade in” or be dominant only at key moments,**

  * The curve should spike up (toward the sample/original) where you want that effect, and drop where you want more of the remix to show through.

---

### **Summary Table**

| Your Intent                      | Curve Shape                             | Outcome                            |
| -------------------------------- | --------------------------------------- | ---------------------------------- |
| Original face throughout         | High sample (top) curve most/all frames | Face dominates, remix motion stays |
| Original face only at key frames | Curve spikes up only at those frames    | Face swaps in/out as desired       |
| Less face transfer               | Lower sample (top) curve                | Remix face dominates               |

---

## **Direct Answer:**

* **You are using the protocol correctly.**
* **But:** If you are not getting as much original face as you want, try raising (not lowering) the sample (top/left) curve at frames/times where you want that face to dominate.
* **Use the blend curve as a “face transfer dial.”** More up = more face; more down = less face.

---

**If you describe exactly what is happening in your current output (e.g., “face doesn’t persist,” “blending is uneven”), I can give a concrete curve adjustment suggestion!**

Would you like a step-by-step for dialing in maximal facial persistence, or advice on artifact avoidance?
