import cv2

im = cv2.imread('./img/logo.png')
cv2.imshow('', im)
cv2.waitKey(0)
cv2.destroyAllWindows()