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

import django_filters





from account.models import (
	Account,
	Organization,
	Staff,
	Batch,
	Student,
	Teacher
)

from academic.models import (
	Course,
	Exam,
	Result
)



from payment.models import (
	Payments
)

from payment.api.serializers import (
	PaymentSerializer
)


from account.api.serializers import (
	AccountResponseSerializer,
	BatchSerializer,
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
	UpdateTeacherSerializer,





	ChangePasswordSerializer,
	UpdateProfileSerializer
)






from academic.api.serializers import (
	CourseSerializer,
	ExamSerializer,
	ResultSerializer,
	ExamListSerializer
)







def get_photo_url(request, photo_url):
	return request.build_absolute_uri(photo_url)

class ObtainAuthTokenView(APIView):

	authentication_classes = []
	permission_classes = []

	def post(self, request):
		context = {}

		mobile = request.POST.get('username')
		password = request.POST.get('password')
		balance = 0.00
		account = authenticate(mobile=mobile, password=password)
		print(account)
		if account:
			if account.is_admin :
				organization = Organization.objects.get(account=account)
			elif account.is_staff :
				staff = Staff.objects.get(account=account)
				organization = staff.organization
				balance = staff.balance
			elif account.is_teacher :
				teacher = Teacher.objects.get(account=account)
				organization = teacher.organization
				balance = teacher.balance
			else:
				student = Student.objects.get(account=account)
				organization = student.organization
				balance = student.balance

				
			try:
				token = Token.objects.get(user=account)
			except Token.DoesNotExist:
				token = Token.objects.create(user=account)
			context['response'] = 'Successfully authenticated.'

			context['email'] = account.email
			context['username'] = account.username
			context['pk'] = account.pk
			context["mobile"] = account.mobile
			context["is_admin"] = account.is_admin
			context["is_staff"] = account.is_staff
			context["is_teacher"] = account.is_teacher
			context["is_student"] = True
			context["balance"] = balance
			context["created_at"] = account.date_joined
			context["updated_at"] = account.last_login
			

			context["organization_name"] = organization.organization_name
			context["address"] = organization.address
			
			context['token'] = token.key
		else:
			context['response'] = 'Error'
			context['error_message'] = 'Invalid credentials'

		return Response(context)

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
			data = AccountResponseSerializer(account).data
			data['response'] = 'successfully registered new user.'

			# data['email'] = account.email
			# data['username'] = account.username
			# data['pk'] = account.pk
			# data["mobile"] = account.mobile
			# data["is_admin"] = True
			# data["is_staff"] = True
			# data["is_teacher"] = account.is_teacher

			# data["balance"] = 0.00
			# data["created_at"] = account.date_joined
			# data["updated_at"] = account.last_login
			

			# data["organization_name"] = serializer.data.get("organization_name", None)
			# data["address"] = serializer.data.get("address", None)
			
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
			data = AccountResponseSerializer(account).data
			data['response'] = 'successfully registered new user.'

			# data['email'] = account.email
			# data['username'] = account.username
			# data['pk'] = account.pk
			# data["mobile"] = account.mobile
			# data["is_admin"] = True
			# data["is_staff"] = True
			# data["is_teacher"] = account.is_teacher
			# data["balance"] = 0.00
			# data["created_at"] = account.date_joined
			# data["updated_at"] = account.last_login
			

			# data["organization_name"] = serializer.data.get("organization_name", None)
			# data["address"] = serializer.data.get("address", None)
			
			token = Token.objects.get(user=account).key
			data['token'] = token
		else:
			data = serializer.errors
		return Response(data)


@api_view(['PUT', ])
@permission_classes((IsAuthenticated,))
def update_profile_view(request):

	if request.method == 'PUT':
		data = {}

		instance = request.user

		username = request.data.get('username', '0')
		if instance.username != username and validate_username(username) != None:
			data['error_message'] = 'That username is already in use.'
			data['response'] = 'Error'
			return Response(data)
			
		email = request.data.get('email', '0').lower()
		if instance.email != email and validate_email(email) != None:
			data['error_message'] = 'That email is already in use.'
			data['response'] = 'Error'
			return Response(data)


		mobile = request.data.get('mobile', '0').lower()
		if instance.mobile != mobile and validate_mobile(mobile) != None:
			data['error_message'] = 'That phone number is already in use.'
			data['response'] = 'Error'
			return Response(data)


		serializer = UpdateProfileSerializer(data=request.data, instance=instance)

		if serializer.is_valid() :
			serializer.save()
			data["response"] = "Successfull"
			data['error_message'] = None
			return Response(data)
		else :
			data["response"] = "Error"
			data['error_message'] = serializer.errors
			return Response(data, status=400)
		


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
			staff = Staff.objects.get(account=account)
			data = StaffSerializer(staff).data

			data['response'] = 'successfully registered new user.'

			# data['email'] = account.email
			# data['username'] = account.username
			# data['pk'] = account.pk
			# data["mobile"] = account.mobile
			# data["is_admin"] = False
			# data["is_staff"] = True
			# data["is_teacher"] = account.is_teacher
			# data["balance"] = 0.00
			# data["created_at"] = account.date_joined
			# data["updated_at"] = account.last_login

			# data["address"] = serializer.data.get("address", None)
			# data["organization_name"] = organization.organization_name

			# token = Token.objects.get(user=account).key
			# data['token'] = token
		else:
			data = serializer.errors
		return Response(data)







@api_view(['PUT', ])
@permission_classes([IsAuthenticated])
def update_staff_view(request, pk):

	if request.method == 'PUT':
		data = {}
		try:
			instance = Account.objects.get(pk=pk)
		except:
			data["response"] = "Error"
			data["error_message"] = "not found"
			return Response(data=data, status=404)
		



		email = request.data.get('email', '0').lower()
		if instance.email != email and validate_email(email) != None:
			data['error_message'] = 'That email is already in use.'
			data['response'] = 'Error'
			return Response(data)


		mobile = request.data.get('mobile', '0').lower()
		if instance.mobile != mobile and validate_mobile(mobile) != None:
			data['error_message'] = 'That phone number is already in use.'
			data['response'] = 'Error'
			return Response(data)

		username = request.data.get('username', '0')
		if instance.username != username and validate_username(username) != None:
			data['error_message'] = 'That username is already in use.'
			data['response'] = 'Error'
			return Response(data)


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
			data["balance"] = 0.00
			data["created_at"] = account.date_joined
			data["updated_at"] = account.last_login

			data["address"] = serializer.data.get("address", None)

			token = Token.objects.get(user=account).key
			data['token'] = token
		else:
			data = serializer.errors
		return Response(data)




@api_view(['POST', ])
@permission_classes([IsAuthenticated])
def registration_student_view(request):

	if request.method == 'POST':
		print(request.data)
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
		user = request.user
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		elif user.is_staff:
			organization = Staff.objects.get(account=user).organization
		else:
			data["response"] = "Error"
			data["error_message"] = "You have no permission to admit student"
			return Response(data=data, status=403)
		context["organization"] = organization
		serializer = StudentRegitrationSerializer(data=request.data, context=context)
		
		if serializer.is_valid():
			account = serializer.save()
			student = Student.objects.get(account=account)


			data = StudentSerializer(student).data
			data['response'] = 'successfully admit new student.'

			data['email'] = account.email
			# data['username'] = account.username
			# data['pk'] = student.pk
			# data["mobile"] = account.mobile
			# if account.profile_picture:
			# 	data["profile_picture"] = get_photo_url(request, account.profile_picture)
			# else:
			# 	data["profile_picture"] = None
			# data["is_active"] = account.is_active
			# data["balance"] = 0.00
			# data["created_at"] = account.date_joined
			# data["updated_at"] = account.last_login

			# data["address"] = serializer.data.get("address", None)
			# if student.batch:
			# 	data["batch"] = student.batch.pk
			# 	data["batch_name"] = student.batch.name
			# else:
			# 	data["batch"] = None
			# 	data["batch_name"] = None
			# data["group"] = student.group
			return Response(data=data)
		else:
			data = serializer.errors

			return Response(data=data, status=400)







@api_view(['PUT', ])
@permission_classes([IsAuthenticated])
def update_student_view(request, pk):

	if request.method == 'PUT':

		print(request.data)
		data = {}
		try:
			student = Student.objects.get(pk=pk)
			instance = student.account
		except:
			data["response"] = "Error"
			data["error_message"] = "not found"
			return Response(data=data, status=404)
		



		username = request.data.get('username', '0')
		if instance.username != username and validate_username(username) != None:
			data['error_message'] = 'That username is already in use.'
			data['response'] = 'Error'
			return Response(data)
			
		email = request.data.get('email', '0').lower()
		if instance.email != email and validate_email(email) != None:
			data['error_message'] = 'That email is already in use.'
			data['response'] = 'Error'
			return Response(data)


		mobile = request.data.get('mobile', '0').lower()
		if instance.mobile != mobile and validate_mobile(mobile) != None:
			data['error_message'] = 'That phone number is already in use.'
			data['response'] = 'Error'
			return Response(data)

		print(instance)

		
		serializer = StudentUpdateSerializer(data=request.data, instance=instance, partial=True)
		
		if serializer.is_valid():
			account = serializer.save()
			student = Student.objects.get(account=account)
			data = StudentSerializer(student).data
			data['response'] = 'successfully update student'

			# data['email'] = account.email
			# data['username'] = account.username
			# data['pk'] = student.pk
			# data["mobile"] = account.mobile
			# if account.profile_picture:
			# 	data["profile_picture"] = get_photo_url(request, account.profile_picture)
			# else:
			# 	data["profile_picture"] = None
			# data["is_active"] = account.is_active
			# data["balance"] = 0.00
			# data["created_at"] = account.date_joined
			# data["updated_at"] = account.last_login

			# data["address"] = serializer.data.get("address", None)
			# if student.batch:
			# 	data["batch"] = student.batch.pk
			# 	data["batch_name"] = student.batch.name
			# else:
			# 	data["batch"] = None
			# 	data["batch_name"] = None
			# data["group"] = student.group
			return Response(data=data)
		else:
			data = serializer.errors









			print(serializer.errors)
			return Response(data=data, status=400)




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
		if request.user.is_admin:
			organization = Organization.objects.get(account=request.user)
		elif request.user.is_staff:
			organization = Staff.objects.get(account=request.user).organization
		else:
			data["response"] = "Error"
			data["error_message"] = "Permission denied"
			return Response(data=data, status=403)
		context["organization"] = organization
		serializer = RegisterTeacherSerializer(data=request.data, context=context)
		
		if serializer.is_valid():
			account = serializer.save()
			teacher = Teacher.objects.get(account=account)
			data = TeacherSerializer(teacher).data
			data['response'] = 'successfully registered new user.'

			# data['email'] = account.email
			# data['username'] = account.username
			# data['pk'] = account.pk
			# data["mobile"] = account.mobile
			# data["is_admin"] = False
			# data["is_staff"] = False
			# data["is_teacher"] = True
			# data["balance"] = 0.00
			# data["created_at"] = account.date_joined
			# data["updated_at"] = account.last_login

			# data["address"] = serializer.data.get("address", None)
			# data["organization_name"] = organization.organization_name
			
			# token = Token.objects.get(user=account).key
			# data['token'] = token
		else:
			data = serializer.errors
		return Response(data)







@api_view(['PUT', ])
@permission_classes([IsAuthenticated])
def update_teacher_view(request, pk):

	if request.method == 'PUT':
		data = {}
		try:
			teacher = Teacher.objects.get(pk=pk)
			print(teacher)
			instance = teacher.account
		except:
			data["response"] = "Error"
			data["error_message"] = "not found"
			return Response(data=data, status=404)
		



		username = request.data.get('username', '0')
		if instance.username != username and validate_username(username) != None:
			data['error_message'] = 'That username is already in use.'
			data['response'] = 'Error'
			return Response(data)
			
		email = request.data.get('email', '0').lower()
		if instance.email != email and validate_email(email) != None:
			data['error_message'] = 'That email is already in use.'
			data['response'] = 'Error'
			return Response(data)


		mobile = request.data.get('mobile', '0').lower()
		if instance.mobile != mobile and validate_mobile(mobile) != None:
			data['error_message'] = 'That phone number is already in use.'
			data['response'] = 'Error'
			return Response(data)

		serializer = UpdateTeacherSerializer(data=request.data, instance=instance)
		
		if serializer.is_valid():
			account = serializer.save()
			teacher = Teacher.objects.get(account=account)
			data = TeacherSerializer(teacher).data
			# data['response'] = 'successfully registered new user.'

			# data['email'] = account.email
			# data['username'] = account.username
			# data['pk'] = account.pk
			# data["mobile"] = account.mobile
			# data["balance"] = 0.00
			# data["created_at"] = account.date_joined
			# data["updated_at"] = account.last_login

			# data["address"] = serializer.data.get("address", None)
			
			# token = Token.objects.get(user=account).key
			# data['token'] = token
		else:
			data = serializer.errors
		return Response(data)





class StaffFilter(django_filters.FilterSet):
	username = django_filters.CharFilter(field_name='account__username', lookup_expr='startswith')
	mobile= django_filters.CharFilter(field_name='account__mobile', lookup_expr='startswith')
	pk = django_filters.CharFilter(lookup_expr='exact')
	class Meta:
		model= Staff
		fields = ["pk", "username", 'mobile']

class ApiStaffListView(ListAPIView):
	serializer_class = StaffSerializer
	authentication_classes = {TokenAuthentication}
	permission_classes = {IsAuthenticated}
	pagination_classes = PageNumberPagination
	filter_class = StaffFilter
	filter_backends = (DjangoFilterBackend, OrderingFilter,)

	def get_queryset(self):
		user = self.request.user
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		elif user.is_staff:
			organization = Staff.objects.get(account=user).organization
		elif user.is_teacher:
			organization = Teacher.objects.get(account=user).organization
		else: 
			organization = Student.objects.get(account=user).organization

		return Staff.objects.filter(organization=organization).order_by("-pk")
			


class StudentFilter(django_filters.FilterSet):
	username = django_filters.CharFilter(field_name='account__username', lookup_expr='startswith')
	mobile= django_filters.CharFilter(field_name='account__mobile', lookup_expr='startswith')
	pk = django_filters.CharFilter(lookup_expr='exact')
	class Meta:
		model= Student
		fields = ["pk", "username", 'mobile']

class ApiStudentListView(ListAPIView):
	serializer_class = StudentSerializer
	authentication_classes = {TokenAuthentication}
	permission_classes = {IsAuthenticated}
	pagination_classes = PageNumberPagination
	filter_class = StudentFilter
	filter_backends = (DjangoFilterBackend, OrderingFilter,)

	def get_queryset(self):
		user = self.request.user
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		elif user.is_staff:
			organization = Staff.objects.get(account=user).organization
		elif user.is_teacher:
			organization = Teacher.objects.get(account=user).organization
		else: 
			organization = Student.objects.get(account=user).organization

		return Student.objects.filter(organization=organization).order_by("-pk")



class TeacherFilter(django_filters.FilterSet):
	username = django_filters.CharFilter(field_name='account__username', lookup_expr='startswith')
	mobile= django_filters.CharFilter(field_name='account__mobile', lookup_expr='startswith')
	pk = django_filters.CharFilter(lookup_expr='exact')
	class Meta:
		model= Teacher
		fields = ["pk", "username", 'mobile']

class ApiTeacherListView(ListAPIView):
	serializer_class = TeacherSerializer
	authentication_classes = {TokenAuthentication}
	permission_classes = {IsAuthenticated}
	pagination_classes = PageNumberPagination
	filter_class = TeacherFilter
	filter_backends = (DjangoFilterBackend, OrderingFilter,)

	def get_queryset(self):
		user = self.request.user
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		elif user.is_staff:
			organization = Staff.objects.get(account=user).organization
		elif user.is_teacher:
			organization = Teacher.objects.get(account=user).organization
		else: 
			organization = Student.objects.get(account=user).organization

		return Teacher.objects.filter(organization=organization).order_by("-pk")

class ApiBatchListView(ListAPIView):
	serializer_class = BatchSerializer
	authentication_classes = {TokenAuthentication}
	permission_classes = {IsAuthenticated}
	pagination_classes = PageNumberPagination
	filter_backends = {SearchFilter, OrderingFilter, DjangoFilterBackend}
	search_fields = {"name"}
	filterset_fields =  {"name"}

	def get_queryset(self):
		user = self.request.user
		if user.is_admin :
			organization = Organization.objects.get(account=user)
		elif user.is_staff:
			organization = Staff.objects.get(account=user).organization
		elif user.is_teacher:
			organization = Teacher.objects.get(account=user).organization
		else: 
			organization = Student.objects.get(account=user).organization

		return Batch.objects.filter(organization=organization).order_by("-pk")




@api_view(['GET', ])
@permission_classes([IsAuthenticated])
def student_profile_view(request):

	if request.method == "GET":

		data = {}
		user = request.user
		if not user.is_admin and not user.is_staff and not user.is_teacher :
			student = Student.objects.get(account=user)
		else :
			data["response"] = "Permission deneid"
			data["error_message"] = "Only student can see his/her profile"
			return Response(data=data, status=403)


		student_serializer = StudentSerializer(student)
		data["student"] = student_serializer.data
		batch = student.batch
		if batch :
			exams = Exam.objects.filter(batch=batch)
			exam_serializer = ExamListSerializer(exams, many=True)
			data["exams"] = exam_serializer.data
		else :
			data["exams"] = []

		payments = Payments.objects.filter(account=user)
		payments_serializer = PaymentSerializer(payments, many=True)
		data["payments"] = payments_serializer.data
		data["response"] = "Successful"
		data["error_message"] = None
		return Response(data=data)

		


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

@api_view(['GET', ])
@permission_classes((IsAuthenticated, ))
def staff_details_view(request, pk):

	try:
		account = Account.objects.get(pk=pk)
		staff = Staff.objects.get(account=account)
	except Account.DoesNotExist:
		return Response(status=status.HTTP_404_NOT_FOUND)

	if request.method == 'GET':
		serializer = StaffSerializer(staff)
		return Response(serializer.data)

@api_view(['GET', ])
@permission_classes((IsAuthenticated, ))
def student_details_view(request, pk):

	try:
		student = Student.objects.get(pk=pk)
	except Account.DoesNotExist:
		data = {}
		data["response"] = "Error"
		data["error_message"] = "Not found"
		return Response(data=data, status=status.HTTP_404_NOT_FOUND)

	if request.method == 'GET':
		serializer = StudentSerializer(student)
		return Response(serializer.data)



@api_view(['GET', ])
@permission_classes((IsAuthenticated, ))
def teacher_details_view(request, pk):

	try:
		account = Account.objects.get(pk=pk)
		teacher = Teacher.objects.get(account=account)
	except Account.DoesNotExist:
		return Response(status=status.HTTP_404_NOT_FOUND)

	if request.method == 'GET':
		serializer = TeacherSerializer(teacher)
		return Response(serializer.data)



@api_view(['POST', ])
@permission_classes([IsAuthenticated])
def create_batch_view(request):

	if request.method == 'POST':
		data = {}
		if request.user.is_admin:
			organization = Organization.objects.get(account=request.user)
		elif request.user.is_staff:
			organization = Staff.objects.get(account=request.user).organization
		else:
			data["response"] = "Error"
			data["error_message"] = "Permission denied"
			return Response(data=data, status=403)

		rdata = request.data.copy()
		rdata["organization"] = organization.pk
		print(rdata)
		serializer = BatchSerializer(data=rdata)
		
		if serializer.is_valid():
			account = serializer.save()
			data = serializer.data
			data['response'] = 'successfully updated.'
			return Response(data)
		else:
			data = serializer.errors
			print(serializer.errors)
			return Response(data, status=400)





@api_view(['PUT', ])
@permission_classes([IsAuthenticated])
def update_batch_view(request, pk):

	if request.method == 'PUT':




		print(request.data)
		data = {}
		instance = Batch.objects.get(pk=pk)
		serializer = BatchSerializer(data=request.data, instance=instance, partial=True)
		
		if serializer.is_valid():
			account = serializer.save()
			data = serializer.data
			data['response'] = 'successfully updated.'
			return Response(data)
		else:
			data = serializer.errors
			return Response(data, status=400)


	

@api_view(['DELETE', ])
@permission_classes([IsAuthenticated])
def delete_batch_view(request, pk):

	if request.method == 'DELETE':
		data = {}
		
		try:
			instance = Batch.objects.get(pk=pk)
			instance.delete()
			data["response"] = "Successfully deleted"
			return Response(data=data)
		except:
			data["error_message"] = "Not found"
			return Response(data, status=400)






class ChangePasswordView(UpdateAPIView):

	serializer_class = ChangePasswordSerializer
	model = Account
	permission_classes = (IsAuthenticated,)
	authentication_classes = (TokenAuthentication,)

	def get_object(self, queryset=None):
		obj = self.request.user
		return obj

	def update(self, request, *args, **kwargs):
		self.object = self.get_object()
		serializer = self.get_serializer(data=request.data)

		if serializer.is_valid():
			# Check old password
			if not self.object.check_password(serializer.data.get("old_password")):
				return Response({"old_password": ["Wrong password."]}, status=status.HTTP_400_BAD_REQUEST)

			# confirm the new passwords match
			new_password = serializer.data.get("new_password")
			confirm_new_password = serializer.data.get("confirm_new_password")
			if new_password != confirm_new_password:
				return Response({"new_password": ["New passwords must match"]}, status=status.HTTP_400_BAD_REQUEST)

			# set_password also hashes the password that the user will get
			self.object.set_password(serializer.data.get("new_password"))
			self.object.save()
			return Response({"response":"successfully changed password"}, status=status.HTTP_200_OK)

		return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)