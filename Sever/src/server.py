
from enum import unique
from flask import Flask,request ,json
from passAuth import keys,data,loadFile
#from models import Course,Student,loadsqldata
from flask_restful import Api,Resource,reqparse
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow




app = Flask(__name__)
api = Api(app)

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///Student_db.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False 



db = SQLAlchemy(app)


class Student(db.Model):
    ID = db.Column(db.Integer,primary_key=True)
    name = db.Column(db.String(100))
    age = db.Column(db.Integer)
    courses = db.relationship('Course',backref='owner')
    

    '''def __init__(self,name,id,age,courseCode):
        self.name = name
        self.ID =id
        self.age = age'''
       
       
class Course(db.Model):
    ID = db.Column(db.Integer,primary_key=True)
    courseCode = db.Column(db.String(50))
    courseTitle = db.Column(db.String(50))
    owner_ID = db.Column(db.Integer,db.ForeignKey('student.ID'))
    

def loadsqldata(L_dic):
    courses=[]
    for i in L_dic:
        stu = Student(name=i['name'],ID=i['id'],age=i["age"])
        for j in i['courses']:
            courses.append(Course(courseCode=j['courseCode'],courseTitle=j['courseTitle'],owner_ID=i['id']))
        stu.courses=courses;
      



toAdd = reqparse.RequestParser();
toAdd.add_argument("name",type=str,help="Student Name needed",required=True)
toAdd.add_argument("id",type=int,help="Student id needed",required=True)
toAdd.add_argument("age",type=int,help="Student age needed",required=True)
toAdd.add_argument("courses",type=list,help="Studen courses",required=True)


student_dic = data
#loadsqldata(student_dic)


class Student_class(Resource):
    def get(self):
        return student_dic
    
    def post(self):
        stu = request.get_json();
        student_dic.append(stu);
        print(stu);
        loadFile(student_dic)
        return {'added':'?'}
    
    def delete(self):
        stu = request.get_json();
        student_dic.remove(stu)
        loadFile(student_dic)

    def put(self):
        stu = request.get_json();
        index = 0
        for i in student_dic:
            if i["id"] == stu["id"]:
                student_dic[index]['courses']=stu['courses']
                break
            index+=1
        loadFile(student_dic)
   

class Courses(Resource):
    def delete(self,id):
        stu = request.get_json(); 
        index = 0
        for i in student_dic:
            if i["id"]==id:
                for j in i["courses"]:
                    if j == stu:
                        i["courses"].remove(stu)
                    break
        loadFile(student_dic)




class auth(Resource):
    def post(self):
        dic = {}
        dic = request.get_json()
        if dic == keys:
            print(True);
            return {'Value':True}
        return {'Value':False}
        
   

api.add_resource(Student_class,'/Student')
api.add_resource(auth,'/Auth')
api.add_resource(Courses,'/Course/<int:id>')
if __name__ == '__main__':
    app.run(debug=True)