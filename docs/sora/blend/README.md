# Deconstruction of the Interface

1.  **The Video Tracks:**
    *   **Top Track (Source A):** The dominant reality. This is your base video.
    *   **Bottom Track (Source B):** The influence reality. This is the source of the features you want to integrate.

2.  **The Influence Curve (The White Line):**
    *   This is not a simple opacity slider; it's a **vertical gradient map**. It dictates, pixel by pixel from top to bottom, how much of Source B should punch through Source A.
    *   **The Vertical Axis:** Represents the vertical position in the video frame. The top of the graph is the top of your video; the bottom of the graph is the bottom of your video.
    *   **The Horizontal Axis:** Represents the blend strength or "influence" of Source B. The far left (0.0) means 0% influence (100% Source A). The far right (1.0) would mean 100% influence (100% Source B).
    *   **Your Curve's Shape:** You have created a sharp dip. This means that at the top and bottom of the video, Source A is almost completely dominant. In the middle section (where the curve dips to the right), you are allowing Source B to become visible. The lowest point of the "U" shape is where the face from your bottom video is most prominent.

3.  **The Numbers: The Bézier Curve Coordinates**
    *   This is the core of your problem. The cryptic numbers, `Custom blend 0.00 0.00, 0.99 0.52, 0.34 0.31`, define the precise shape of your curve. This is likely a non-standard representation of a cubic Bézier curve's control points. While the exact syntax is proprietary, their *function* is universal. They control the start, end, and curvature of the line.
    *   Your goal—making the blend "perfect"—means you need to manipulate this curve with surgical precision. This requires changing the **depth**, **position**, and **sharpness** of that dip.

---

### **Actionable Solutions: Fine-Tuning the Blend**

Based on your desire for the top video to be "predominant" with only "a few aspects" from the bottom, your issue is likely that the blend is either slightly too strong (the dip is too far right), too soft (the dip is too wide), or slightly misaligned vertically.

Here are three tweaked settings ("recipes") designed to give you more control. Replace your current numbers with these to see the effect.

#### **Recipe A: The "Subtle Graft" - Less Influence, Sharper Falloff**
This will make the features from the bottom video more subtle and the transition between the two videos cleaner and less "ghostly." The blend will be more focused on a very specific vertical slice.

*   **Goal:** Weaken the overall blend and tighten the transition area.
*   **Logic:** Pull the curve's main dip to the left (less influence) and sharpen the curvature of the "U" shape.
*   **New Values:** `0.00 0.00, 0.85 0.55, 0.45 0.25`

#### **Recipe B: The "Dominant Eyes" - Shifting the Focus Vertically**
This assumes the key features you want from the bottom video are slightly higher or lower than where they are currently appearing. This example shifts the blend region slightly *up*.

*   **Goal:** Keep the blend intensity but move the entire effect area.
*   **Logic:** Adjust the vertical parameters (`y` coordinates) of the control points to move the dip up or down the frame.
*   **New Values (Shifted Up):** `0.00 0.00, 0.99 0.42, 0.34 0.21`

#### **Recipe C: The "Feathered Blend" - Softer, Wider Transition**
If the edges of your blend are too harsh, you need to soften the transition. This creates a more gradual, dreamlike effect rather than a hard mask.

*   **Goal:** Increase the "feathering" of the blend.
*   **Logic:** Widen the "U" shape of the curve by pulling the control handles further apart horizontally.
*   **New Values:** `0.00 0.00, 1.20 0.52, 0.10 0.31` (Note: Values can sometimes exceed 1.0 or go below 0.0 to control the curve's tension outside the frame).

---

# Master Cheatsheet for Consistent Results

To "consistently work this feature," stop guessing. Use this logic table.

| To Achieve This...                               | Manipulate the Curve By...                               | Which Means Changing the Numbers To...                       |
| :----------------------------------------------- | :------------------------------------------------------- | :----------------------------------------------------------- |
| **Make the bottom video's features STRONGER**    | Moving the lowest point of the dip **further to the right**. | Increase the `X` value of the middle number pairs.           |
| **Make the bottom video's features WEAKER**      | Moving the lowest point of the dip **further to the left**.  | Decrease the `X` value of the middle number pairs.           |
| **Make the blend transition SHARPER / HARDER**   | Making the "U" shape of the dip **narrower**.              | Move the `X` values of the control points closer together.   |
| **Make the blend transition SOFTER / GHOSTLIER** | Making the "U" shape of the dip **wider**.                 | Move the `X` values of the control points further apart.     |
| **Move the blended area UP in the video**        | Moving the entire dip **higher on the graph**.           | Decrease the `Y` values of the number pairs.                 |
| **Move the blended area DOWN in the video**      | Moving the entire dip **lower on the graph**.            | Increase the `Y` values of the number pairs.                 |

---

### Lower Clip Emphasis

0.00, 0.38, 0.74, 0.53, 1.00, 1.00
