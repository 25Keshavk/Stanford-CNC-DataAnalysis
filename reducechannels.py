'''
Resizes images.

@author Keshav Kotamraju

'''

import cv2

num_images = 2001

for i in range(1, num_images + 1):
    file_path = "resized-results/frame-" + str(i) + ".tif"

    img = cv2.imread(file_path, cv2.IMREAD_UNCHANGED)

    # print('Initial shape: ', img.shape)

    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    cv2.imwrite("gray-results/frame-" + str(i) + ".tif", gray)

    # print('Final shape: ', gray.shape)


