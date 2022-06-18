from functools import partial
from unittest import result
from django.http import request
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.views import APIView
from rest_framework.generics import UpdateAPIView
from django.contrib.auth import authenticate, login
from rest_framework.authentication import TokenAuthentication, SessionAuthentication
from rest_framework.decorators import api_view, authentication_classes, permission_classes

from rest_framework.generics import ListAPIView
from rest_framework.filters import SearchFilter, OrderingFilter
from rest_framework.pagination import PageNumberPagination
from rest_framework.generics import ListAPIView
from django_filters.rest_framework import DjangoFilterBackend

from itertools import groupby
from django.core import serializers
from django.db.models import Sum



from academic.models import (
	Course,
	Exam,
	Result
)

from academic.api.serializers import (
	CourseSerializer,
	ExamSerializer,
	ResultSerializer
)



from account.models import (
	Account,
	Organization,
	Staff,
	Batch,
	Student,
	Teacher
)









@api_view(['POST', ])
@permission_classes((IsAuthenticated,))
def create_course_view(request):

	if request.method == "POST":
		data = {}
		user = request.user
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		elif user.is_staff:
			organization = Staff.objects.get(account=user).organization
		else:
			data["response"] = "Permission denied"
			data["error_message"] = "You cann't create any course"
			return Response(data=data, status=403)
		rdata = request.data.copy()
		rdata["organization"] = organization.pk
		print(rdata)
		serializer = CourseSerializer(data=rdata)

		if serializer.is_valid():
			model = serializer.save()
			data = serializer.data
			data["response"] = "Successfully created"
			data["error_message"] = None

			return Response(data=data)
		else:
			data["response"] = "Error"
			data["error_message"] = serializer.errors
			return Response(data=data, status=400)


@api_view(['PUT', ])
@permission_classes((IsAuthenticated,))
def update_course_view(request, pk):

	if request.method == "PUT":
		data = {}
		user = request.user
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		elif user.is_staff:
			organization = Staff.objects.get(account=user).organization
		else:
			data["response"] = "Permission denied"
			data["error_message"] = "You cann't update any course"
			return Response(data=data, status=403)
		rdata = request.data.copy()
		rdata["organization"] = organization.pk
		print(rdata)


		try:
			instance = Course.objects.get(pk=pk)
		except:
			data["response"] = "Error"
			data["error_message"] = "Course not found"
			return Response(data=data, status=400)
		serializer = CourseSerializer(data=rdata, instance=instance)

		if serializer.is_valid():
			model = serializer.save()
			data = serializer.data
			data["response"] = "Successfully created"
			data["error_message"] = None

			return Response(data=data)
		else:
			data["response"] = "Error"
			data["error_message"] = serializer.errors
			return Response(data=data, status=400)

class ApiCourseListView(ListAPIView):
	serializer_class = CourseSerializer
	authentication_classes = {TokenAuthentication}
	permission_classes = {IsAuthenticated}
	pagination_classes = PageNumberPagination
	filter_backends = {SearchFilter, OrderingFilter, DjangoFilterBackend}
	search_fields = {"name",}
	filterset_fields =  {"name",}

	def get_queryset(self):
		user = self.request.user
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		elif user.is_staff:
			organization = Staff.objects.get(account=user).organization
		elif user.teacher:
			organization = Teacher.objects.get(account=user).organization
		else: 
			organization = Student.objects.get(account=user).organization

		return Course.objects.filter(organization=organization)

@api_view(['POST', ])
@permission_classes((IsAuthenticated,))
def create_exam_view(request):

	if request.method == "POST":
		data = {}
		user = request.user
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		elif user.is_staff:
			organization = Staff.objects.get(account=user).organization
		else:
			data["response"] = "Permission denied"
			data["error_message"] = "You cann't create any exam"
			return Response(data=data, status=403)
		rdata = request.data.copy()
		rdata["organization"] = organization.pk
		print(rdata)
		serializer = ExamSerializer(data=rdata)

		if serializer.is_valid():
			model = serializer.save()
			data = serializer.data
			data["response"] = "Successfully created"
			data["error_message"] = None

			return Response(data=data)
		else:
			data["response"] = "Error"
			data["error_message"] = serializer.errors
			return Response(data=data, status=400)

@api_view(['PUT', ])
@permission_classes((IsAuthenticated,))
def update_exam_view(request, pk):

	if request.method == "PUT":
		data = {}
		user = request.user
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		elif user.is_staff:
			organization = Staff.objects.get(account=user).organization
		else:
			data["response"] = "Permission denied"
			data["error_message"] = "You cann't update any course"
			return Response(data=data, status=403)
		rdata = request.data.copy()
		rdata["organization"] = organization.pk
		print(rdata)


		try:
			instance = Exam.objects.get(pk=pk)
		except:
			data["response"] = "Error"
			data["error_message"] = "Exam not found"
			return Response(data=data, status=400)
		serializer = ExamSerializer(data=rdata, instance=instance)

		if serializer.is_valid():
			model = serializer.save()
			data = serializer.data
			data["response"] = "Successfully created"
			data["error_message"] = None

			return Response(data=data)
		else:
			data["response"] = "Error"
			data["error_message"] = serializer.errors
			return Response(data=data, status=400)







class ApiExamListView(ListAPIView):
	serializer_class = ExamSerializer
	authentication_classes = {TokenAuthentication}
	permission_classes = {IsAuthenticated}
	pagination_classes = PageNumberPagination
	filter_backends = {SearchFilter, OrderingFilter, DjangoFilterBackend}
	search_fields = {"name",}
	filterset_fields =  {"name",}

	def get_queryset(self):
		user = self.request.user
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		elif user.is_staff:
			organization = Staff.objects.get(account=user).organization
		elif user.teacher:
			organization = Teacher.objects.get(account=user).organization
		else: 
			organization = Student.objects.get(account=user).organization

		return Exam.objects.filter(organization=organization)



@api_view(['POST', ])
@permission_classes((IsAuthenticated,))
def create_result_view(request):

	if request.method == "POST":
		data = {}
		user = request.user
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		elif user.is_staff:
			organization = Staff.objects.get(account=user).organization
		else:
			data["response"] = "Permission denied"
			data["error_message"] = "You cann't create result"
			return Response(data=data, status=403)
		rdata = request.data.copy()


		course = rdata.get("course", None)
		if course == None:
			data["response"] = "Error"
			data["error_message"] = "Course is required field"
			return Response(data=data, status=400)
		rdata["organization"] = organization.pk
		print(rdata)
		serializer = ResultSerializer(data=rdata)

		if serializer.is_valid():
			model = serializer.save()
			data = serializer.data
			data["response"] = "Successfully created"
			data["error_message"] = None

			return Response(data=data)
		else:
			data["response"] = "Error"
			data["error_message"] = serializer.errors
			return Response(data=data, status=400)









@api_view(['PUT', ])
@permission_classes((IsAuthenticated,))
def update_result_view(request, pk):

	if request.method == "PUT":
		data = {}
		user = request.user
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		elif user.is_staff:
			organization = Staff.objects.get(account=user).organization
		else:
			data["response"] = "Permission denied"
			data["error_message"] = "You cann't update any result"
			return Response(data=data, status=403)
		rdata = request.data.copy()


		course = rdata.get("course", None)
		if course == None:
			data["response"] = "Error"
			data["error_message"] = "Course is required field"
			return Response(data=data, status=400)
		rdata["organization"] = organization.pk
		print(rdata)
		rdata["organization"] = organization.pk
		print(rdata)


		try:
			instance = Result.objects.get(pk=pk)
		except:
			data["response"] = "Error"
			data["error_message"] = "Result not found"
			return Response(data=data, status=400)
		serializer = ResultSerializer(data=rdata, instance=instance)

		if serializer.is_valid():
			model = serializer.save()
			data = serializer.data
			data["response"] = "Successfully created"
			data["error_message"] = None

			return Response(data=data)
		else:
			data["response"] = "Error"
			data["error_message"] = serializer.errors
			return Response(data=data, status=400)


def find_student(list, item):
	for x in list:
		details = {}
		if x["course__pk"] == item["pk"]:
			details["pk"] = item["pk"]
			details["name"] = item["name"]
			details["mark"] = x["marks"]
			return details
	details["pk"] = item["pk"]
	details["name"] = item["name"]
	details["mark"] = "-"
	return details
@api_view(['GET', ])
@permission_classes((IsAuthenticated,))
def student_indivisula_result_view(request, exam_pk, student_pk):

	if request.method == "GET":

		exam = Exam.objects.get(pk=exam_pk)
		course_list = []
		for x in exam.courses.all():
			details = {}
			details["name"] = x.name
			details["pk"] = x.pk
			course_list.append(details)

		student = Student.objects.get(pk=student_pk)

		result = Result.objects\
			.filter(exam=exam, student=student)\
				.values("course__pk")\
					.annotate(marks=Sum("mark"))
			

		result_list = []
		for x in result:
			result_list.append(x)

		new_list = []

		for x in course_list:
			new_list.append(find_student(result_list, x))
			

		print(result_list)
		return Response(data=new_list)








def check_course_list(list, item):
	for x in list:
		details = {}
		is_exist = None
		for y in item["result"]:
			if x["pk"] == y["course"]:
				is_exist = 1
				break
		if is_exist == None:
			details["course"] = x["pk"]
			details["course_name"] = x["name"]
			details["mark"] = "-"
			item["result"].append(details)
				
	return item

def create_student_set(list):
	new_list = []








	def check(abc):
		for x in new_list:
			if x["student"] == abc:
				return 1
		return None
	
	for x in list:
		if check(x["student__pk"]) == None:
			details = {}
			details["student"] = x["student__pk"]
			details["student_name"] = x["student__account__username"]
			course_details_list = []
			for y in list:
				if y["student__pk"] == details["student"]:
					course_details = {}
					course_details["course"] = y["course__pk"]
					course_details["course_name"] = y["course__name"]
					course_details["mark"] = str(y["mark__sum"])
					course_details_list.append(course_details)
			details["result"] = course_details_list
			new_list.append(details)
			
	return new_list

@api_view(['GET', ])
@permission_classes((IsAuthenticated,))
def exam_result_view(request, pk):

	if request.method == "GET":

		exam = Exam.objects.get(pk=pk)
		course_list = []
		for x in exam.courses.all():
			details = {}
			details["name"] = x.name
			details["pk"] = x.pk
			course_list.append(details)
		print(course_list)






		
		# result = []
		# for key, model in groupby(Result.objects.filter(exam=exam), lambda x : x.student):
		# 	print(key, model)

		result = Result.objects.filter(exam=exam)\
			.values("course__name", "student__pk", "course__pk", "student__account__username")\
				.annotate(Sum("mark"))

		
		print(result)
		print("\n")
		# print(create_student_set(result))


		new_list = []
		for x in create_student_set(result):

			new_list.append(check_course_list(course_list, x))
			

		# result_list = []
		# for x in result:
		# 	result_list.append(x)

		# new_list = []

		# for x in course_list:
		# 	new_list.append(find_student(result_list, x))
			

		# print(result_list)
		return Response(data=new_list)