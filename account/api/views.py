from functools import partial
from django.http import request
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.views import APIView
from rest_framework.generics import UpdateAPIView
from django.contrib.auth import authenticate, login
from rest_framework.authentication import TokenAuthentication
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
	StudentRegitrationSerializer,
	RegisterTeacherSerializer
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
			data["address"] = serializer.data.get("address", None)
			data["organization_name"] = serializer.data.get("organization_name", None)
			data["is_admin"] = True
			data["is_staff"] = True
			data["is_teacher"] = account.is_teacher
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
			data["address"] = serializer.data.get("address", None)
			data["organization_name"] = organization.organization_name
			data["is_admin"] = False
			data["is_staff"] = True
			data["is_teacher"] = account.is_teacher
			token = Token.objects.get(user=account).key
			data['token'] = token
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
			data["address"] = serializer.data.get("address", None)
			data["organization_name"] = organization.organization_name
			data["is_admin"] = False
			data["is_staff"] = False
			data["is_teacher"] = False
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
			data["address"] = serializer.data.get("address", None)
			data["organization_name"] = organization.organization_name
			data["is_admin"] = False
			data["is_staff"] = False
			data["is_teacher"] = True
			token = Token.objects.get(user=account).key
			data['token'] = token
		else:
			data = serializer.errors
		return Response(data)