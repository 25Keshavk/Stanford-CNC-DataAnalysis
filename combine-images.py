'''
Combines multiple tif files into one tif. 

@author Keshav Kotamraju

'''


import tifftools

num_images = 2001

input1 = tifftools.read_tiff('gray-results/frame-1.tif')

for i in range(1, num_images + 1):
    input2 = tifftools.read_tiff('gray-results/frame-' + str(i) + '.tif')
    input1['ifds'].extend(input2['ifds'])

tifftools.write_tiff(input1, 'combined-results/rigid-full.tif')