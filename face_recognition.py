
import time
import serial
from imutils.video import VideoStream
from imutils.video import FPS
import face_recognition
import imutils
import pickle
import time
import cv2
import numpy as np
import firebase_admin
from firebase_admin import credentials, messaging, initialize_app, storage, firestore
import datetime
import base64
import ssl
import os

# disabling ssl certification verification
ssl._create_default_https_context = ssl._create_unverified_context
# Path to your service account JSON file
service_account_path = '/home/pi4/Desktop/security/security.json'


# Initialize Firebase using the service account credentials
cred = credentials.Certificate(service_account_path)
initialize_app(cred,{'storageBucket':'intrudersystem-6ed32.appspot.com'})



bucket_name = 'intrudersystem-6ed32.appspot.com'


# Access Firestore
firestore_client = firestore.client()

# Set up the serial connection
serial_port = '/dev/ttyUSB0' # Replace with the actual serial port
baud_rate = 9600

# Open the serial connection
ser = serial.Serial(serial_port, baud_rate)
time.sleep(10)
ser.reset_input_buffer()
print('Serial ok')


#import all the images
folderPath = '/home/pi4/Desktop/security/KnownFaces'
modePathList = os.listdir(folderPath)
imgList = []
nameList=[]
for path in modePathList:
 imgList.append(cv2.imread(os.path.join(folderPath,path)))
 nameList.append(os.path.splitext(path)[0])
 print(nameList)

#function to create all the incodings
def findEncodings(imgList):
 encodeList = []
 for img in imgList:
  img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
  encode = face_recognition.face_encodings(img)[0]
  encodeList.append(encode)

 return encodeList
print("Encoding started…")
#encodeListKnown = findEncodings(imgList)
#encodeListKnownWithNames = [encodeListKnown,nameList]
print("Encoding complete")

#file = open("EncodeFile.p",'wb')
#pickle.dump(encodeListKnownWithNames,file)
#file.close()
print("file saved")


def detect_faces():
 print('detecting face')
 start_motion_time = time.time()

 status = 0
# Load the pre-trained face detection cascade
 face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')

# Open the video capture
 vs = cv2.VideoCapture(0)  # Use 0 for the default camera

 while time.time() - start_motion_time <= 5:
    print('DETECTING face run 1')
    # Read the video frame
    ret, frame = vs.read()

    # Convert the frame to grayscale for face detection
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    # Detect faces in the frame
    faces = face_cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=5, minSize=(30, 30))

    # Draw rectangles around the detected faces
    if len(faces) > 0:
        for (x, y, w, h) in faces:
            cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)
        status = 1
        print('face detected')
        return status
        break
 if(status==0):
  while time.time() - start_motion_time <= 10:
    print('DETECTING face run 2')

    # Read the video frame
    ret, frame = vs.read()

    # Convert the frame to grayscale for face detection
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    # Detect faces in the frame
    faces = face_cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=5, minSize=(30, 30))

    # Draw rectangles around the detected faces
    if len(faces) > 0:
        for (x, y, w, h) in faces:
            cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)
        status = 1
        print('face detected')
        return status
        break
 if(status==0):
  while time.time() - start_motion_time <= 15:
    print('DETECTING face run 3')

    # Read the video frame
    ret, frame = vs.read()

    # Convert the frame to grayscale for face detection
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    # Detect faces in the frame
    faces = face_cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=5, minSize=(30, 30))

    # Draw rectangles around the detected faces
    if len(faces) > 0:
        for (x, y, w, h) in faces:
            cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)
        status = 1
        print('face detected')
        return status
        break
 if(status==0):       
  while time.time() - start_motion_time <= 30:
    print('DETECTING face run 30 sec')

    # Read the video frame
    ret, frame = vs.read()

    # Convert the frame to grayscale for face detection
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    # Detect faces in the frame
    faces = face_cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=5, minSize=(30, 30))

    # Draw rectangles around the detected faces
    if len(faces) > 0:
        for (x, y, w, h) in faces:
            cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)
        status = 1
        print('face detected')
        return status
        break
 if(status==0):       
   while time.time() - start_motion_time <= 35:
    print('DETECTING face run one min')

    # Read the video frame
    ret, frame = vs.read()

    # Convert the frame to grayscale for face detection
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    # Detect faces in the frame
    faces = face_cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=5, minSize=(30, 30))

    # Draw rectangles around the detected faces
    if len(faces) > 0:
        for (x, y, w, h) in faces:
            cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)
        status = 1
            
        print('face detected')
        return status
        break
 print('no face detected')

 cv2.destroyAllWindows()
 vs.release()
 return status

# recognize face
def  recognize_face():
 print('recognizing face..')   
    
# load the encoding file
 print("Loading encode file…")
 file = open('EncodeFile.p','rb' )
 encodeListKnownWithNames = pickle.load(file)
 file.close()
 encodeListKnown, nameList = encodeListKnownWithNames
 #print(nameList)
 print("Encode file loaded")
 
# store results
 detection = False
 person = None

# initialize the video stream using the USB webcam
 vs = VideoStream(src=0).start()
 time.sleep(2.0)
 start_time=time.time()
# start the FPS counter
 fps = FPS().start()

 while True:
  img = vs.read()
  img = imutils.resize(img, width=500)

# find location faces in the current frame
  faceCurrFrame = face_recognition.face_locations(img)

# create encodings of the faces detected
  encodeCurrFrame = face_recognition.face_encodings(img, faceCurrFrame)

# loop through all the encodings and generate outcome according to whether they match or not
# using zip because we want to use a for loop with two variables
  for encodeFace, faceLoc in zip(encodeCurrFrame, faceCurrFrame):
    # compare encodeface unknown to encodeface known
    matches = face_recognition.compare_faces(encodeListKnown, encodeFace,tolerance=0.4)

  
    faceDis = face_recognition.face_distance(encodeListKnown, encodeFace)

    # getting the index of the least value
    matchIndex = np.argmin(faceDis)

    if matches[matchIndex]:
        detection = True
        person = nameList[matchIndex]

        y1, x2, y2, x1 = faceLoc
        y1, x2, y2, x1 = y1 * 4, x2 * 4, y2 * 4, x1 * 4
        # draw the rectangle across the face
        cv2.rectangle(img, (x1, y1), (x2, y2), (0, 255, 0), 2)
    
    else:
        detection = False

# display the image to our screen
  cv2.imshow("Facial Recognition is Running", img)
  key = cv2.waitKey(1) & 0xFF
  
  if ((time.time()-start_time>=5) and (detection==True)):
    print("Status: {}".format(detection))
    print("Person: {}".format(person))
    break
  elif ((time.time()-start_time>=60) and(detection==False)):
    print("Status: {}".format(detection))
    print("Person: {}".format(person))
    break

# update the FPS counter
 fps.update()
# stop the timer and display FPS information
 fps.stop()
 print("[INFO] elapsed time: {:.2f}".format(fps.elapsed()))
 print("[INFO] approx. FPS: {:.2f}".format(fps.fps()))

# do a bit of cleanup
 vs.stop()
 cv2.destroyAllWindows()
 print('detection done')
 return detection
# sending notification when only morion is recognized



def send_notification(title, body):
  print('sending notification..')
  try:
    message = messaging.Message(
        notification=messaging.Notification(
        title=title,
       body=body
    ),
    token= 'cuE5qotoTpyyg0EdD0koYJ:APA91bGD82619km0Aqt1e1eDtoi0oK3elMJ7HPAJGklioH4mE3pq4Ia_YjqyMOQoqSJyTzW2YilJYtcLk_1g-j3Qcs6e1IglXkVbNDoYcc5dDOg2ynbcgqdjMgqPuXUQqp8rH6LOsbtz')
    response = messaging.send(message)
    print('Notification sent successfully:', response)

  except:
      
    print('Notification sent not successfully')
  
def motion_intruder_error():
# Capture a photo from the webcam
 photo = capture_photo()

# Generate a unique photo name using the current timestamp
 photo_name = generate_photo_name()

# save photo in folder
 save_image(photo,photo_name)
 
 # Upload the photo to Firebase Storage
 upload_photo(photo_name)
 
# Capture a photo from the USB webcam
def capture_photo():
# Initialize the webcam
 cap = cv2.VideoCapture(0) # Use 0 for the default camera or change the index if necessary

# Capture a frame from the webcam
 ret, frame = cap.read()

# Release the webcam
 cap.release()

 return frame
 
 
def save_image(frame,name):
    image_path=f'/home/pi4/Desktop/security/unknownFacess/{name}.jpg'
    cv2.imwrite(image_path,frame)
    print('Image saved')

# Convert image to base64
def image_to_base64(image):
 _, buffer = cv2.imencode('.jpg', image)
 encoded_image = base64.b64encode(buffer)
 return encoded_image.decode('utf-8')

# Upload the photo to Firebase Storage
def upload_photo(photo_name):
 file_path=f'/home/pi4/Desktop/security/unknownFacess/{photo_name}.jpg'
 filename=os.path.basename(file_path)
 bucket = storage.bucket()
 photo_ref = bucket.blob(f'securityPhotos/{filename}.jpg')
 photo_ref.upload_from_filename(file_path)

 
# Generate a unique photo name using the current timestamp
def generate_photo_name():
 now = datetime.datetime.now()
 timestamp = now.strftime("%Y%m%d%H%M%S")
 return timestamp

# Function to read the distance from the ultrasonic sensor
def read_distance():
 print('reading distance...')
 sendCommand('0')
 try:
     
    response = ser.readline().decode().strip() # Read the response from the Arduino
    if len(response.split(","))>1:
        if response: # Check if the response is not empty
           # Convert the response to an integer
          # distance_str = ''.join(filter(str.isdigit, response.split(",")[1]))  # Extract only the digits from the response
          distance = int(float(response.split(",")[1]))  # Convert the extracted value to an integerdistance_str = response.split(',')[0]
          sendCommand('3')
          return distance
        else:
          sendCommand('3')  
          return None # Return None if the response is empty# Convert the response to a floating-point number

 except Exception as e:
    print(e)

   


def sendCommand(command):
  ACTION = (command+ "\n").encode('utf_8')
  ser.write(ACTION)
#   line = ser.readline().decode('utf-8').rstrip()
#   print(line)
#time.sleep(2)
sendCommand('3')
try:

 while True:
 
  distance = read_distance() # Read the distance from the ultrasonic sensor
  print(distance)
#   print(ser.readline().decode().strip())
  if(distance is not None and int(distance)<100):
    sendCommand('2')
   
    
    while True:
#        aurdino_display('Face Rognition') 
     faceDetection = detect_faces()
     print('face detect status {face}'.format(face=faceDetection))
     if(faceDetection==1):
          
          recognition=recognize_face()
          print('detection status: {detect}'.format(detect=recognition))
          if(recognition):
             sendCommand('2')
             print('door opened through face recog')
             break
          else:
               motion_intruder_error()  
               print('Not Matched')
               send_notification('Intruder Detected','Face not recognized')
               break
     elif(faceDetection==0):
          print('face not detected') 
          motion_intruder_error()
          send_notification('Intruder Detected','Motion detected but no face found in recogniton cam')
          break
     break     
except KeyboardInterrupt:
# Clean up the serial connection on Ctrl+C
 ser.close()
 
 
  
            