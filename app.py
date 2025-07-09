import os
from werkzeug.utils import secure_filename
from flask import Flask, render_template, request
from flask_mysqldb import MySQL
from PIL import Image
import numpy as np
from tensorflow.keras.models import load_model

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = 'static/uploads/'
app.config['SECRET_KEY'] = 'wackin'


app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'bootcamp_final'

mysql = MySQL(app)


model = load_model('model/traffic_signs_model_final.h5')


def prepare_image(image_path):
    img = Image.open(image_path).convert('RGB')
    img = img.resize((32, 32))
    img = np.array(img) / 255.0
    img = np.expand_dims(img, axis=0)
    return img.astype(np.float32)

@app.route('/', methods=['GET', 'POST'])
def index():
    predictions = []
    image_path = None

    if request.method == 'POST':
        file = request.files['image']
        if file:
            filename = secure_filename(file.filename)
            image_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            file.save(image_path)

            # Predict
            img = prepare_image(image_path)
            pred = model.predict(img)[0]
            top_indices = pred.argsort()[-3:][::-1] 

          
            cur = mysql.connection.cursor()
            cur.execute("INSERT INTO predictions (filename) VALUES (%s)", (filename,))
            mysql.connection.commit()
            prediction_id = cur.lastrowid  

            
            for rank, index in enumerate(top_indices, start=1):
                confidence = float(pred[index])
                sign_id = index 
                cur.execute("""
                    INSERT INTO prediction_results (prediction_id, sign_id, confidence, rank)
                    VALUES (%s, %s, %s, %s)
                """, (prediction_id, sign_id, confidence, rank))

               
                cur.execute("SELECT label FROM traffic_signs WHERE sign_id = %s", (sign_id,))
                label = cur.fetchone()[0]
                predictions.append((label, confidence))

            mysql.connection.commit()
            cur.close()

    return render_template('index.html', predictions=predictions, image_path=image_path)

if __name__ == '__main__':
    app.run(debug=True)
