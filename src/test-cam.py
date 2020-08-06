import cv2

cap = cv2.VideoCapture(0)
print(cap.get(cv2.CAP_PROP_FPS))

while True:
    _, frame = cap.read()
    frame = cv2.resize(frame, (640, 480))
    cv2.imshow('frame', frame)
    if cv2.waitKey(1) & 0xff == ord('q'):
        break
cap.release()
cv2.destroyAllWindows()
