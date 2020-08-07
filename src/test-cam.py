import cv2
import time

cap = cv2.VideoCapture(0)
cap.set(cv2.CAP_PROP_FRAME_WIDTH, 1920)
cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 1080)
print(cap.get(cv2.CAP_PROP_FPS))
num_frame = 0
fps = 0
start = time.time()
while True:
    _, frame = cap.read()
    num_frame += 1
    # frame = cv2.resize(frame, (640, 480))
    if num_frame == 30:
        end = time.time()
        sec = end - start
        fps = num_frame / sec
        start = time.time()
        num_frame = 0
    cv2.imshow(f'frame', frame)
    print(f'FPS: {fps:.2f} fps')
    if cv2.waitKey(1) & 0xff == ord('q'):
        break
cap.release()
cv2.destroyAllWindows()
