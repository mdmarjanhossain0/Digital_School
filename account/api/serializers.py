from rest_framework import serializers

from account.models import (
	Account,
	Organization,
	Staff,
	Batch,
	Student,
	Teacher
)



from rest_framework.authtoken.models import Token


#This is the magic function which does the work
def get_photo_url(self, obj):
	request = self.context.get('request')
	photo_url = obj.account.profile_picture.url
	return request.build_absolute_uri(photo_url)

class RegistrationOrganizationSerializer(serializers.ModelSerializer):

	password2 				= serializers.CharField(style={'input_type': 'password'}, write_only=True)
	organization_name 		= serializers.CharField()
	address 				= serializers.CharField(required=False)

	class Meta:
		model = Account
		fields = [
			'email',
			'username',
			'mobile',
			'profile_picture',
			'password',
			'password2',


			'organization_name',
			'address'
			]
		extra_kwargs = {
				'password': {'write_only': True},
		}	


	def	save(self):

		account = Account(
					email=self.validated_data.get("email", None),
					username=self.validated_data['username'],
					mobile=self.validated_data['mobile'],
					profile_picture=self.validated_data.get('profile_picture', None),
					is_admin=True,
					is_staff=True
				)
		password = self.validated_data['password']
		password2 = self.validated_data['password2']
		if password != password2:
			raise serializers.ValidationError({'password': 'Passwords must match.'})
		account.set_password(password)
		account.save()



		organization = Organization(
			account = account,
			organization_name = self.validated_data["organization_name"],
			address = self.validated_data.get("address", None)
		)
		organization.save()
		return account




class UpdateOrganizationSerializer(serializers.ModelSerializer):

	organization_name 		= serializers.CharField(required=False)
	address 				= serializers.CharField(required=False)

	class Meta:
		model = Account
		fields = [
			'email',
			'username',
			'mobile',
			'profile_picture',
			'organization_name',
			'address'
			]	

		def update(self, instance, validated_data):
			
			org = Organization.objects.get(account=instance)

			instance.email = validated_data.get("email", instance.email)
			instance.username = validated_data.get("username", instance.username)
			instance.mobile = validated_data.get("mobile", instance.mobile)
			instance.profile_picture = validated_data.get("profile_picture", instance.profile_picture)

			org.organization_name = validated_data.get("organization_name", org.organization_name)
			org.address = validated_data.get("address", org.address)
			org.save()

			return instance
			











class RegistrationStaffSerializer(serializers.ModelSerializer):

	password2 				= serializers.CharField(style={'input_type': 'password'}, write_only=True)
	address 				= serializers.CharField(required=False)

	class Meta:
		model = Account
		fields = [
			'email',
			'username',
			'mobile',
			'profile_picture',
			'password',
			'password2',

			'address'
			]
		extra_kwargs = {
				'password': {'write_only': True},
		}	


	def	save(self):

		organization = self.context.get("organization")
		account = Account(
					email=self.validated_data.get("email", None),
					username=self.validated_data['username'],
					mobile=self.validated_data['mobile'],
					profile_picture=self.validated_data.get('profile_picture', None),
					is_staff=True
				)
		password = self.validated_data['password']
		password2 = self.validated_data['password2']
		if password != password2:
			raise serializers.ValidationError({'password': 'Passwords must match.'})
		account.set_password(password)
		account.save()



		staff = Staff(
			account = account,
			organization = organization,
			address = self.validated_data.get("address", None)
		)
		staff.save()
		return account


class UpdateStaffSerializer(serializers.ModelSerializer):

	address 				= serializers.CharField(required=False)

	class Meta:
		model = Account
		fields = [
			'email',
			'username',
			'mobile',
			'profile_picture',
			'address'
			]	

	def update(self, instance, validated_data):
			
			staff = Staff.objects.get(account=instance)

			instance.email = validated_data.get("email", instance.email)
			instance.username = validated_data.get("username", instance.username)
			instance.mobile = validated_data.get("mobile", instance.mobile)
			instance.profile_picture = validated_data.get("profile_picture", instance.profile_picture)

			staff.address = validated_data.get("address", staff.address)
			staff.save()
			
			return instance











class BatchSerializer(serializers.ModelSerializer):

	class Meta:
		model = Batch
		fields = "__all__"











class StudentRegitrationSerializer(serializers.ModelSerializer):

	password2 				= serializers.CharField(style={'input_type': 'password'}, write_only=True)
	batch 					= serializers.IntegerField(allow_null=True)
	address 				= serializers.CharField(required=False)

	class Meta:
		model = Account
		fields = [
			'email',
			'username',
			'mobile',
			'profile_picture',
			'password',
			'password2',


			'batch',
			'address'
			]
		extra_kwargs = {
				'password': {'write_only': True},
		}	


	def	save(self):

		organization = self.context.get("organization")
		try:
			batch = Batch.objects.get(pk = self.validated_data.get("batch", None))
		except:
			batch = None
		account = Account(
					email=self.validated_data.get('email', None),
					username=self.validated_data['username'],
					mobile=self.validated_data['mobile'],
					profile_picture=self.validated_data.get('profile_picture', None),
				)
		password = self.validated_data['password']
		password2 = self.validated_data['password2']
		if password != password2:
			raise serializers.ValidationError({'password': 'Passwords must match.'})
		account.set_password(password)

		account.save()
		

		if batch != None:
			student = Student(
				account=account,
				organization = organization,
				batch = batch,
				address = self.validated_data.get("address", None)
			)
		else:
			student = Student(
				account=account,
				organization = organization,
				address = self.validated_data.get("address", None)
			)
		student.save()
		return account



	
class StudentUpdateSerializer(serializers.ModelSerializer):

	address 				= serializers.CharField(required=False)

	class Meta:
		model = Account
		fields = [
			'email',
			'username',
			'mobile',
			'profile_picture',
			'batch',
			'address'
			]	

	def update(self, instance, validated_data):


			student = Student.objects.get(account=instance)

			instance.email = validated_data.get("email", instance.email)
			instance.username = validated_data.get("username", instance.username)
			instance.mobile = validated_data.get("mobile", instance.mobile)
			instance.profile_picture = validated_data.get("profile_picture", instance.profile_picture)

			
			student.batch = validated_data.get("batch", student.batch)
			student.address = validated_data.get("address", student.address)
			student.save()
			
			return instance







class RegisterTeacherSerializer(serializers.ModelSerializer):

	password2 				= serializers.CharField(style={'input_type': 'password'}, write_only=True)
	address 				= serializers.CharField(required=False)

	class Meta:
		model = Account
		fields = [
			'email',
			'username',
			'mobile',
			'profile_picture',
			'password',
			'password2',




			'address'
			]
		extra_kwargs = {
				'password': {'write_only': True},
		}	


	def	save(self):

		organization = self.context.get("organization")
		account = Account(
					email=self.validated_data.get('email', None),
					username=self.validated_data['username'],
					mobile=self.validated_data['mobile'],
					profile_picture=self.validated_data.get('profile_picture', None),
					is_teacher = True
				)
		password = self.validated_data['password']
		password2 = self.validated_data['password2']
		if password != password2:
			raise serializers.ValidationError({'password': 'Passwords must match.'})
		account.set_password(password)
		account.save()



		teacher = Teacher(

			account=account,
			organization = organization,
			address = self.validated_data.get("address", None)
		)
		teacher.save()
		return account




class UpdateTeacherSerializer(serializers.ModelSerializer):

	address 				= serializers.CharField(required=False)

	class Meta:
		model = Account
		fields = [
			'email',
			'username',
			'mobile',
			'profile_picture',
			'address'
			]	

	def update(self, instance, validated_data):
			
			teacher = Teacher.objects.get(account=instance)

			instance.email = validated_data.get("email", instance.email)
			instance.username = validated_data.get("username", instance.username)
			instance.mobile = validated_data.get("mobile", instance.mobile)
			instance.profile_picture = validated_data.get("profile_picture", instance.profile_picture)

			teacher.address = validated_data.get("address", teacher.address)
			teacher.save()
			
			return instance



class StaffSerializer(serializers.ModelSerializer):

	address 					= serializers.CharField(required=False)
	pk 							= serializers.SerializerMethodField("get_pk")
	email 						= serializers.SerializerMethodField("get_email")
	mobile 						= serializers.SerializerMethodField("get_mobile")
	username 					= serializers.SerializerMethodField("get_username")
	profile_picture 			= serializers.SerializerMethodField("get_profile_picture")


	class Meta:
		model = Staff
		fields = [
			'pk',
			'email',
			'username',
			'mobile',
			'profile_picture',
			'address',
			'balance',
			'created_at',
			'updated_at'
			]

	def get_pk(self, obj):
		return obj.account.pk

	def get_email(self, obj):
		return obj.account.email

	def get_mobile(self, obj):
		return obj.account.mobile

	def get_username(self, obj):
		return obj.account.username

	def get_pk(self, obj):
		return obj.account.profile_picture.url




class StaffSerializer(serializers.ModelSerializer):

	address 					= serializers.CharField(required=False)
	pk 							= serializers.SerializerMethodField("get_pk")
	email 						= serializers.SerializerMethodField("get_email")
	mobile 						= serializers.SerializerMethodField("get_mobile")
	username 					= serializers.SerializerMethodField("get_username")
	profile_picture 			= serializers.SerializerMethodField("get_profile_picture")


	class Meta:
		model = Staff
		fields = [
			'pk',
			'email',
			'username',
			'mobile',
			'profile_picture',
			'address',
			'balance',
			'created_at',
			'updated_at'
			]

	def get_pk(self, obj):
		return obj.account.pk

	def get_email(self, obj):
		return obj.account.email

	def get_mobile(self, obj):
		return obj.account.mobile

	def get_username(self, obj):
		return obj.account.username

	def get_profile_picture(self, obj):
		if obj.account.profile_picture:
			return obj.account.profile_picture.url
		else:
			return None


class StudentSerializer(serializers.ModelSerializer):

	address 					= serializers.CharField(required=False)
	pk 							= serializers.SerializerMethodField("get_pk")
	email 						= serializers.SerializerMethodField("get_email")
	mobile 						= serializers.SerializerMethodField("get_mobile")
	username 					= serializers.SerializerMethodField("get_username")
	profile_picture 			= serializers.SerializerMethodField("get_profile_picture")


	class Meta:
		model = Student
		fields = [
			'pk',
			'email',
			'username',
			'mobile',
			'profile_picture',
			'address',
			'balance',
			'batch',
			'created_at',
			'updated_at'
			]

	def get_pk(self, obj):
		return obj.account.pk

	def get_email(self, obj):
		return obj.account.email

	def get_mobile(self, obj):
		return obj.account.mobile

	def get_username(self, obj):
		return obj.account.username

	def get_profile_picture(self, obj):
		if obj.account.profile_picture:
			return obj.account.profile_picture.url
		else:
			return None


class TeacherSerializer(serializers.ModelSerializer):

	address 					= serializers.CharField(required=False)
	pk 							= serializers.SerializerMethodField("get_pk")
	email 						= serializers.SerializerMethodField("get_email")
	mobile 						= serializers.SerializerMethodField("get_mobile")
	username 					= serializers.SerializerMethodField("get_username")
	profile_picture 			= serializers.SerializerMethodField("get_profile_picture")


	class Meta:
		model = Teacher
		fields = [
			'pk',
			'email',
			'username',
			'mobile',
			'profile_picture',
			'address',
			'balance',
			'created_at',
			'updated_at'
			]

	def get_pk(self, obj):
		return obj.account.pk

	def get_email(self, obj):
		return obj.account.email

	def get_mobile(self, obj):
		return obj.account.mobile

	def get_username(self, obj):
		return obj.account.username

	def get_profile_picture(self, obj):
		if obj.account.profile_picture:
			return obj.account.profile_picture.url
		else:
			return None





class ChangePasswordSerializer(serializers.Serializer):

	old_password 				= serializers.CharField(required=True)
	new_password 				= serializers.CharField(required=True)
	confirm_new_password 		= serializers.CharField(required=True)





























# from account.api.serializers import RegistrationOrganizationSerializer
# import json
# data = {
# 	"mobile" : "01711224455",
# 	"username" : "abc1",
# 	"password" : "adminpassword",
# 	"password2" : "adminpassword",
# 	"organization_name" : "abc1",
# 	"address" : "BD"
# }


# jdata = json.loads(data)
# sr = RegistrationOrganizationSerializer(data=jdata)