from functools import partial
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

from .validators import validate_email, validate_mobile, validate_username
from rest_framework.authtoken.models import Token





from account.models import (
	Account,
	Organization,
	Staff,
	Batch,
	Student,
	Teacher
)

from account.api.serializers import (
	RegistrationOrganizationSerializer,
	RegistrationStaffSerializer,
	StaffSerializer,
	StudentRegitrationSerializer,
	RegisterTeacherSerializer,
	StudentSerializer,
	TeacherSerializer,

	UpdateOrganizationSerializer,
	UpdateStaffSerializer,
	StudentUpdateSerializer,
	UpdateTeacherSerializer
)







@api_view(['POST', ])
@permission_classes([])
@authentication_classes([])
def registration_organization_view(request):

	if request.method == 'POST':
		data = {}
		email = request.data.get('email', '0').lower()
		if validate_email(email) != None:
			data['error_message'] = 'That email is already in use.'
			data['response'] = 'Error'
			return Response(data)


		mobile = request.data.get('mobile', '0').lower()
		if validate_mobile(mobile) != None:
			data['error_message'] = 'That phone number is already in use.'
			data['response'] = 'Error'
			return Response(data)

		username = request.data.get('username', '0')
		if validate_username(username) != None:
			data['error_message'] = 'That username is already in use.'
			data['response'] = 'Error'
			return Response(data)

		serializer = RegistrationOrganizationSerializer(data=request.data)
		
		if serializer.is_valid():
			account = serializer.save()
			data['response'] = 'successfully registered new user.'

			data['email'] = account.email
			data['username'] = account.username
			data['pk'] = account.pk
			data["mobile"] = account.mobile
			data["is_admin"] = True
			data["is_staff"] = True
			data["is_teacher"] = account.is_teacher
			

			data["organization_name"] = serializer.data.get("organization_name", None)
			data["address"] = serializer.data.get("address", None)
			
			token = Token.objects.get(user=account).key
			data['token'] = token
		else:
			data = serializer.errors
		return Response(data)


@api_view(['PUT', ])
@permission_classes((IsAuthenticated,))
def update_organization_view(request, pk):

	if request.method == 'PUT':
		data = {}
		email = request.data.get('email', '0').lower()
		if validate_email(email) != None:
			data['error_message'] = 'That email is already in use.'
			data['response'] = 'Error'
			return Response(data)


		mobile = request.data.get('mobile', '0').lower()
		if validate_mobile(mobile) != None:
			data['error_message'] = 'That phone number is already in use.'
			data['response'] = 'Error'
			return Response(data)

		username = request.data.get('username', '0')
		if validate_username(username) != None:
			data['error_message'] = 'That username is already in use.'
			data['response'] = 'Error'
			return Response(data)


		instance = Account.objects.get(pk=pk)
		serializer = UpdateOrganizationSerializer(data=request.data, instance=instance)
		
		if serializer.is_valid():
			account = serializer.save()
			data['response'] = 'successfully registered new user.'

			data['email'] = account.email
			data['username'] = account.username
			data['pk'] = account.pk
			data["mobile"] = account.mobile
			data["is_admin"] = True
			data["is_staff"] = True
			data["is_teacher"] = account.is_teacher
			

			data["organization_name"] = serializer.data.get("organization_name", None)
			data["address"] = serializer.data.get("address", None)
			
			token = Token.objects.get(user=account).key
			data['token'] = token
		else:
			data = serializer.errors
		return Response(data)


@api_view(['POST', ])
@permission_classes([IsAuthenticated])
def registration_staff_view(request):

	if request.method == 'POST':
		data = {}
		email = request.data.get('email', '0').lower()
		if validate_email(email) != None:
			data['error_message'] = 'That email is already in use.'
			data['response'] = 'Error'
			return Response(data)


		mobile = request.data.get('mobile', '0').lower()
		if validate_mobile(mobile) != None:
			data['error_message'] = 'That phone number is already in use.'
			data['response'] = 'Error'
			return Response(data)

		username = request.data.get('username', '0')
		if validate_username(username) != None:
			data['error_message'] = 'That username is already in use.'
			data['response'] = 'Error'
			return Response(data)


		context = {}
		organization = Organization.objects.get(account=request.user)
		context["organization"] = organization
		serializer = RegistrationStaffSerializer(data=request.data, context=context)
		
		if serializer.is_valid():
			account = serializer.save()
			data['response'] = 'successfully registered new user.'

			data['email'] = account.email
			data['username'] = account.username
			data['pk'] = account.pk
			data["mobile"] = account.mobile
			data["is_admin"] = False
			data["is_staff"] = True
			data["is_teacher"] = account.is_teacher

			data["address"] = serializer.data.get("address", None)
			data["organization_name"] = organization.organization_name

			token = Token.objects.get(user=account).key
			data['token'] = token
		else:
			data = serializer.errors
		return Response(data)







@api_view(['PUT', ])
@permission_classes([IsAuthenticated])
def update_staff_view(request, pk):

	if request.method == 'PUT':
		data = {}
		email = request.data.get('email', '0').lower()
		if validate_email(email) != None:
			data['error_message'] = 'That email is already in use.'
			data['response'] = 'Error'
			return Response(data)


		mobile = request.data.get('mobile', '0').lower()
		if validate_mobile(mobile) != None:
			data['error_message'] = 'That phone number is already in use.'
			data['response'] = 'Error'
			return Response(data)

		username = request.data.get('username', '0')
		if validate_username(username) != None:
			data['error_message'] = 'That username is already in use.'
			data['response'] = 'Error'
			return Response(data)


		organization = Organization.objects.get(account=request.user)
		instance = Account.objects.get(pk=pk)
		serializer = UpdateStaffSerializer(data=request.data, instance=instance)
		
		if serializer.is_valid():
			account = serializer.save()
			data['response'] = 'successfully registered new user.'

			data['email'] = account.email
			data['username'] = account.username
			data['pk'] = account.pk
			data["mobile"] = account.mobile
			data["is_admin"] = False
			data["is_staff"] = True
			data["is_teacher"] = account.is_teacher

			data["address"] = serializer.data.get("address", None)
			data["organization_name"] = organization.organization_name

			token = Token.objects.get(user=account).key
			data['token'] = token
		else:
			data = serializer.errors
		return Response(data)




@api_view(['POST', ])
@permission_classes([IsAuthenticated])
def registration_student_view(request):

	if request.method == 'POST':
		data = {}
		email = request.data.get('email', '0').lower()
		if validate_email(email) != None:
			data['error_message'] = 'That email is already in use.'
			data['response'] = 'Error'
			return Response(data)


		mobile = request.data.get('mobile', '0').lower()
		if validate_mobile(mobile) != None:
			data['error_message'] = 'That phone number is already in use.'
			data['response'] = 'Error'
			return Response(data)

		username = request.data.get('username', '0')
		if validate_username(username) != None:
			data['error_message'] = 'That username is already in use.'
			data['response'] = 'Error'
			return Response(data)
		context = {}
		organization = Organization.objects.get(account=request.user)
		context["organization"] = organization
		serializer = StudentRegitrationSerializer(data=request.data, context=context)
		
		if serializer.is_valid():
			account = serializer.save()
			data['response'] = 'successfully registered new user.'

			data['email'] = account.email
			data['username'] = account.username
			data['pk'] = account.pk
			data["mobile"] = account.mobile
			data["is_admin"] = False
			data["is_staff"] = False
			data["is_teacher"] = False

			data["address"] = serializer.data.get("address", None)
			data["organization_name"] = organization.organization_name

			token = Token.objects.get(user=account).key
			data['token'] = token
		else:
			data = serializer.errors
		return Response(data)







@api_view(['PUT', ])
@permission_classes([IsAuthenticated])
def update_student_view(request, pk):

	if request.method == 'PUT':
		data = {}
		email = request.data.get('email', '0').lower()
		if validate_email(email) != None:
			data['error_message'] = 'That email is already in use.'
			data['response'] = 'Error'
			return Response(data)


		mobile = request.data.get('mobile', '0').lower()
		if validate_mobile(mobile) != None:
			data['error_message'] = 'That phone number is already in use.'
			data['response'] = 'Error'
			return Response(data)

		username = request.data.get('username', '0')
		if validate_username(username) != None:
			data['error_message'] = 'That username is already in use.'
			data['response'] = 'Error'
			return Response(data)

		organization = Organization.objects.get(account=request.user)
		instance = Account.objects.get(pk=pk)
		serializer = StudentUpdateSerializer(data=request.data, instance=instance)
		
		if serializer.is_valid():
			account = serializer.save()
			data['response'] = 'successfully registered new user.'

			data['email'] = account.email
			data['username'] = account.username
			data['pk'] = account.pk
			data["mobile"] = account.mobile
			data["is_admin"] = False
			data["is_staff"] = False
			data["is_teacher"] = False

			data["address"] = serializer.data.get("address", None)
			data["organization_name"] = organization.organization_name

			token = Token.objects.get(user=account).key
			data['token'] = token
		else:
			data = serializer.errors
		return Response(data)




@api_view(['POST', ])
@permission_classes([IsAuthenticated])
def registration_teacher_view(request):

	if request.method == 'POST':
		data = {}
		email = request.data.get('email', '0').lower()
		if validate_email(email) != None:
			data['error_message'] = 'That email is already in use.'
			data['response'] = 'Error'
			return Response(data)


		mobile = request.data.get('mobile', '0').lower()
		if validate_mobile(mobile) != None:
			data['error_message'] = 'That phone number is already in use.'
			data['response'] = 'Error'
			return Response(data)

		username = request.data.get('username', '0')
		if validate_username(username) != None:
			data['error_message'] = 'That username is already in use.'
			data['response'] = 'Error'
			return Response(data)

		context = {}
		organization = Organization.objects.get(account=request.user)
		context["organization"] = organization
		serializer = RegisterTeacherSerializer(data=request.data, context=context)
		
		if serializer.is_valid():
			account = serializer.save()
			data['response'] = 'successfully registered new user.'

			data['email'] = account.email
			data['username'] = account.username
			data['pk'] = account.pk
			data["mobile"] = account.mobile
			data["is_admin"] = False
			data["is_staff"] = False
			data["is_teacher"] = True

			data["address"] = serializer.data.get("address", None)
			data["organization_name"] = organization.organization_name
			
			token = Token.objects.get(user=account).key
			data['token'] = token
		else:
			data = serializer.errors
		return Response(data)







@api_view(['PUT', ])
@permission_classes([IsAuthenticated])
def update_teacher_view(request, pk):

	if request.method == 'PUT':
		data = {}
		email = request.data.get('email', '0').lower()
		if validate_email(email) != None:
			data['error_message'] = 'That email is already in use.'
			data['response'] = 'Error'
			return Response(data)


		mobile = request.data.get('mobile', '0').lower()
		if validate_mobile(mobile) != None:
			data['error_message'] = 'That phone number is already in use.'
			data['response'] = 'Error'
			return Response(data)

		username = request.data.get('username', '0')
		if validate_username(username) != None:
			data['error_message'] = 'That username is already in use.'
			data['response'] = 'Error'
			return Response(data)

		organization = Organization.objects.get(account=request.user)
		instance = Account.objects.get(pk=pk)
		serializer = UpdateTeacherSerializer(data=request.data, instance=instance)
		
		if serializer.is_valid():
			account = serializer.save()
			data['response'] = 'successfully registered new user.'

			data['email'] = account.email
			data['username'] = account.username
			data['pk'] = account.pk
			data["mobile"] = account.mobile
			data["is_admin"] = False
			data["is_staff"] = False
			data["is_teacher"] = True

			data["address"] = serializer.data.get("address", None)
			data["organization_name"] = organization.organization_name
			
			token = Token.objects.get(user=account).key
			data['token'] = token
		else:
			data = serializer.errors
		return Response(data)











class ApiStaffListView(ListAPIView):
	serializer_class = StaffSerializer
	authentication_classes = {TokenAuthentication}
	permission_classes = {IsAuthenticated}
	pagination_classes = PageNumberPagination
	filter_backends = {SearchFilter, OrderingFilter, DjangoFilterBackend}
	search_fields = {'account__username', 'account__mobile',
					 'account__email'}
	filterset_fields =  {'account__username', 'account__mobile',
					 'account__email'}

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

		return Staff.objects.filter(organization=organization)






class ApiStudentListView(ListAPIView):
	serializer_class = StudentSerializer
	authentication_classes = {TokenAuthentication}
	permission_classes = {IsAuthenticated}
	pagination_classes = PageNumberPagination
	filter_backends = {SearchFilter, OrderingFilter, DjangoFilterBackend}
	search_fields = {'account__username', 'account__mobile',
					 'account__email'}
	filterset_fields =  {'account__username', 'account__mobile',
					 'account__email'}

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

		return Student.objects.filter(organization=organization)




class ApiTeacherListView(ListAPIView):
	serializer_class = TeacherSerializer
	authentication_classes = {TokenAuthentication}
	permission_classes = {IsAuthenticated}
	pagination_classes = PageNumberPagination
	filter_backends = {SearchFilter, OrderingFilter, DjangoFilterBackend}
	search_fields = {'account__username', 'account__mobile',
					 'account__email'}
	filterset_fields =  {'account__username', 'account__mobile',
					 'account__email'}

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

		return Teacher.objects.filter(organization=organization)


@api_view(['DELETE', ])
@permission_classes([IsAuthenticated])
def delete_staff_view(request, pk):

	if request.method == "DELETE":
		data = {}

		user = request.user
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		else:
			data["response"] = "Permission deneid"
			data["error_message"] = "Only organization owner can delete staff"
			return Response(data=data, status=403)

	try:
		staff = Account.objects.get(pk = pk)
		if Staff.objects.get(account=staff).organization == organization:
			staff.account.delete()
			data["response"] = "Successfully deleted."
			data["error_message"] = None
			return Response(data=data)
	except:
		data["response"] = "Error"
		data["error_message"] = "Staff not found"
		return Response(data=data, status=404)


@api_view(['DELETE', ])
@permission_classes([IsAuthenticated])
def delete_student_view(request, pk):

	if request.method == "DELETE":
		data = {}

		user = request.user
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		elif user.is_staff:
			organization = Staff.objects.get(account=user).organization
		else:
			data["response"] = "Permission deneid"
			data["error_message"] = "Only organization owner can delete student"
			return Response(data=data, status=403)

	try:
		student = Account.objects.get(pk = pk)
		print(student)
		if Student.objects.get(account=student).organization == organization:
			student.delete()
			data["response"] = "Successfully deleted."
			data["error_message"] = None
			return Response(data=data)
	except:
		data["response"] = "Error"
		data["error_message"] = "Student not found"
		return Response(data=data, status=404)


@api_view(['DELETE', ])
@permission_classes([IsAuthenticated])
def delete_teacher_view(request, pk):

	if request.method == "DELETE":
		data = {}

		user = request.user
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		elif user.is_staff:
			organization = Staff.objects.get(account=user).organization
		else:
			data["response"] = "Permission deneid"
			data["error_message"] = "Only organization owner can delete teacher"
			return Response(data=data, status=403)
	try:
		teacher = Account.objects.get(pk = pk)
		if Teacher.objects.get(account=teacher).organization == organization:
			teacher.account.delete()
			data["response"] = "Successfully deleted."
			data["error_message"] = None
			return Response(data=data)
	except:
		data["response"] = "Error"
		data["error_message"] = "Teacher not found"
		return Response(data=data, status=404)


