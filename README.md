6.869 Final Project
======================

GelSight is retrographic sensor that is able to resolve surface microstructure over four orders of magnitude, from the centimeter to micron range (1,2). By coating an elastomeric slab with a microscopic layer of reflective paint, the an image of microscopic topography pressed into the painted side is visible through the unpainted (clear) side. Since the bidirectional reflectance distribution function (BDRF) of the paint-elastomer interface is known, it is possible to accurately reconstruct the 3D shape of the surface by taking pictures with different lighting angles and recombining them.
The potential applications of GelSight are far reaching. From forensic applications of reconstructing pressure details of handwritten text, to medical applications of subcutaneous structure inference, to robotics applications of tactile texture sensing, it is clear that intense development of the technology could make a significant impact. In order to further this goal, we propose to develop image recognition and analysis tools using depth map data from GelSight. Specifically, we are interested in designing and testing computer vision algorithms for GelSight images in two applications: inferring the physical structure of a hard object embedded within an elastic material, and developing a stitched depth image of a section of human skin that reveals the anatomical structure underneath. 
While both of these goals require overlapping sets of tools and techniques, we will treat them separately for the time being in order to define our goals more clearly. First, we seek to understand and model how the GelSight detector represents the subsurface physical structure of a nonrigid material. Graduate student Stella Jia in the Adelson lab worked extensively on using Gelsight to detect whether there is a lump under a soft tissue (a “phantom”), and proved that the device works well for basic detection. In our project, we want to detect more properties of the lump, such as its depth and shape. The result would be helpful in medical fields, such as accurately detecting whether breast tissue contains a cancerous tumor or not. This endeavor has already been explored to some extent (3,5), albeit in a less precise manner.
The potential applications of GelSight’s ability to detect lumps within deformable objects are far reaching. The idea of inferring bumps from within phantom objects can be naturally extended to infer semi-rigid structures such as bones, tendons and teeth by imaging the skin layer. As a first milestone, we would like to capture, over a grid, a series of image pairs from a human hand. For each grid patch on the hand, we shall capture a pair of images: one from GelSight (representing a depth map of bone/tendon structure) and the other from an RGB camera depicting a color image. 
Since the GelSight depth and RGB images are generated iteratively, we need a robust method to stitch different images to form a coherent output image. We plan to make use of the color images as the primary cue to stitch all the images together. The goal is to superimpose the anatomical features (bones/tendons) obtained by GelSight with the original color space image of the hand to generate an X-ray like image. A similar procedure could be carried out to obtain the 3D teeth structure by pressing GelSight around the mouth area and superimposing 3D teeth data with the original face image.
Overall, while there is already significant work being done with the GelSight detector, we believe our project will not only demonstrate our knowledge of computer vision techniques, but will also help advance the technology into new and applicable domains. 

Here is an outline for how we plan to complete this project:

1. We will make new tissue models with different shape and depth of lumps, and lumps out of different materials. We will also take images of the lumps with different applied forces. By comparing the images, we can find out how the GelSight image change when items are underneath, and try to build a model that recognizes the cross-sectional shape of a lump. 

2. Try to use the depth image (the GelSight sensor output) change as a function of applied sensor pressure to infer the 3D shape lump (for lumps that have a nontrivial 3D shape, such as a sphere, ovoid, or cube). We will also examine shear information to see if it provides information about depth differences.

3. Using image stitch to combine different images of a large lump, thus inferring its full shape.

Simultaneously, we will work on taking an all-encompassing set of images of some anatomic structure (probably the back of a hand or teeth through the cheek/lips). This will entail the following steps:

1. Determine which type of gel (different gels have different stiffness, density, etc.) will be most useful for our particular anatomical measurement.

2. Develop a method of calibrating an RGB camera and the GelSight detector to minimize difficulties in registering the images with each other. Design a procedure for producing uniform GelSight images by controlling for pressure, surface orientation, body pose, etc.

3. Take the set of pictures and stitch the RGB images together into a mosaic with a computer vision technique, such as SIFT with RANSAC. Use the stitching parameters to create an analogous GelSight mosaic. Examine the mosaic to see if it makes any sense.

4. Try to do stitching on the GelSight images independently. Try to infer the 3D shape of the anatomy substructure in a way that is analogous to scene reconstruction in photo tourism, or potentially using shear information.

What we have now:
The working GelSight sensor. Some data and prior experience of the lump detection. An algorithm for detecting spherical lumps in GelSight images exists. 

Citations

[1] Johnson, M. K., Cole, F., Raj, A., & Adelson, E. H. (2011). Microgeometry capture using an elastomeric sensor. ACM Transactions on Graphics (TOG), 30(4), 46.

[2] Johnson, Micah K., and Edward H. Adelson. "Retrographic sensing for the measurement of surface texture and shape." Computer Vision and Pattern Recognition, 2009. CVPR 2009. IEEE Conference on. IEEE, 2009.

[3] Trejos, A. L., Jayender, J., Perri, M. T., Naish, M. D., Patel, R. V., & Malthaner, R. A. (2009). Robot-assisted Tactile Sensing for Minimally Invasive Tumor Localization. The International Journal of Robotics Research, 28(9), 1118–1133. doi:10.1177/0278364909101136

[4] Liu, Ce, et al. "Exploring features in a bayesian framework for material recognition." Computer Vision and Pattern Recognition (CVPR), 2010 IEEE.

[5] J.C. Gwilliam, Z. Pezzementi, E. Jantho, A.M. Okamura, and S. Hsiao. Human vs. robotic tactile sensing: Detecting lumps in soft tissue. Haptics Symposium, 2010 IEEE.
