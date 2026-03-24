# Consistent Character Generation

1. **Access the Generator**: Navigate to the "Create Image" module within the Nano Banana interface.
2. **Upload Reference**: Click the `+` icon to upload your base reference image.
3. **Configure Settings**: 
   * Set the aspect ratio to **16:9** to ensure adequate horizontal space.
   * Set the generation outputs to at least **2** for comparative selection.
4. **Input the Prompt**: Paste the following prompt verbatim (captured at 00:49 in the video) to generate the turnaround sheet.

> "Create a professional character reference sheet based strictly on the uploaded reference image. Use a clean, neutral plain background and present the sheet as a technical model turnaround while matching the exact visual style of the reference (same realism level, rendering approach, texture, color treatment, and overall aesthetic). Arrange the composition into two horizontal rows. Top row: four full-body standing views placed side-by-side in this order: front view, left profile view (facing left), right profile view (facing right), back view. Bottom row: three highly detailed close-up portraits aligned beneath the full-body row in this order: front portrait, left profile portrait (facing left), right profile portrait (facing right). Maintain perfect identity consistency across every panel. Keep the subject in a relaxed A-pose and with consistent scale and alignment between views, accurate anatomy, and clear silhouette; ensure even spacing and clean panel separation, with uniform framing and consistent head height across the full-body lineup and consistent facial scale across the portraits. Lighting should be consistent across all panels (same direction, intensity, and softness), with natural, controlled shadows that preserve detail without dramatic mood shifts. Output a crisp, print-ready reference sheet look, sharp details."

* **`based strictly on the uploaded reference image`**: This directive bypasses the model's default stochastic tendency to hallucinate novel facial geometry, enforcing a strict 1:1 token lock with the seed ingredient.
* **`technical model turnaround`**: Invokes training weights associated with 3D modeling pipelines (ZBrush, Blender, Maya), forcing the AI to consider the subject as a volumetric object bound by physical space rather than a flat canvas.
* **`Arrange the composition into two horizontal rows...`**: Explicit structural formatting. This rigid instruction prevents the model from generating random, asymmetrical collage layouts which would break automated parsing scripts later in the pipeline.
* **`relaxed A-pose`**: Reduces joint occlusion. This provides the cleanest possible data for subsequent animation, deepfake rigging, or skeletal tracking modules.
* **`uniform framing and consistent head height`**: Critical for the "Superset Verification Protocol." If the generated character's height or skeletal proportions fluctuate between angles, the result is a failure and must be scrapped immediately.
* **`natural, controlled shadows without dramatic mood shifts`**: Eliminates high-contrast or chiaroscuro lighting that obscures textural details, ensuring the geometry is perfectly illuminated for ingestion into video-generation nodes.

5. **Heuristic Selection**: Review the outputs. You are looking for absolute structural cohesion. The face must be clearly identifiable in the front-facing hero shots. The scale must be 1:1 across the horizontal plane. Discard any outputs showing morphological drift. The chosen output is now your **Master Reference Sheet**.

6. **Video Generation Integration**: To maintain character consistency in video generation, always include the newly generated character sheet as an active "Ingredient" alongside your prompt and starting frame.
   - Switch your operational terminal to the video generation module.
   - You may use one of the front-facing portraits from your Master Reference Sheet, or generate a unique "Start Image" using the character.
   - You **MUST** upload the Master Reference Sheet as an "Ingredient" for the video generation. Do not rely solely on the Start Image. The Master Reference Sheet acts as an anchor in the latent space, constantly reminding the diffusion model of the character's geometry from all angles as it predicts movement (e.g., a 360-degree spin). Failure to include this anchor will result in catastrophic identity drift during complex animations.

7. **Generate Multiple Sheets**: Execute the Phase 5 workflow for Target A and Target B independently. You must possess two flawless Master Reference Sheets.
   - In the video generation interface, upload **both** Master Reference Sheets as active ingredients.
   - Ensure your animation prompt explicitly defines the actions of both entities and conceptually binds them to their respective sheets (e.g., "Two characters interacting. Character A [referencing Sheet 1] shakes hands with Character B [referencing Sheet 2]"). The model will heuristically map the distinct geometries to the defined entities, preventing visual bleeding or amalgamation.
