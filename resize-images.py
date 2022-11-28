'''
Converts images to grayscale.

@author Keshav Kotamraju

'''

import cv2

num_images = 2001

for i in range(1, num_images + 1):
    file_path = "results/corrected-frame-" + str(i) + ".tif"

    img = cv2.imread(file_path)

    # Initially is 1167 × 875 and want it to be 875 x 875 cropped first 
    # Have 292 on each side of whitespace
    cropped_image = img[0:875, 146:1021] 
    
    # now resize to 512 by 512 like original input
    resized_image = cv2.resize(cropped_image, (512, 512))

    # print(cropped_image.shape)

    cv2.imwrite("resized-results/frame-" + str(i) + ".tif", resized_image)
