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



class AccountResponseSerializer(serializers.ModelSerializer) :

	organization_name 		= serializers.SerializerMethodField("get_organization_name")
	created_at 				= serializers.SerializerMethodField("get_created_at")
	updated_at 				= serializers.SerializerMethodField("get_updated_at")
	balance 				= serializers.SerializerMethodField("get_balance")
	address 				= serializers.SerializerMethodField("get_address")

	class Meta:
		model = Account
		fields = [
			'pk',
			'email',
			'username',
			'mobile',
			'profile_picture',
			'is_admin',
			'is_staff',
			'is_teacher',
			'created_at',
			'updated_at',
			'balance',


			'organization_name',
			'address'
			]

	
	def get_organization_name(self, obj) :
		if obj.is_admin :
			organization = Organization.objects.get(account=obj)
		elif obj.is_staff:
			organization = Staff.objects.get(account=obj).organization
		elif obj.is_teacher:
			organization = Teacher.objects.get(account=obj).organization
		else: 
			organization = Student.objects.get(account=obj).organization
		return organization.organization_name

	def get_balance(self, obj) :
		if obj.is_admin :
			balance = 0.00
		elif obj.is_staff:
			balance = Staff.objects.get(account=obj).balance
		elif obj.is_teacher:
			balance = Teacher.objects.get(account=obj).balance
		else: 
			balance = Student.objects.get(account=obj).balance
		return balance




	
	def get_updated_at(self, obj) :
		return obj.last_login

	


	def get_created_at(self, obj) :
		return obj.date_joined

	
	def get_address(self, obj) :
		if obj.is_admin :
			address = Organization.objects.get(account=obj).address
		elif obj.is_staff:
			address = Staff.objects.get(account=obj).address
		elif obj.is_teacher:
			address = Teacher.objects.get(account=obj).address
		else: 
			address = Student.objects.get(account=obj).address
		return address

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



class UpdateProfileSerializer(serializers.ModelSerializer):

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

		instance.username = validated_data.get("username", instance.username)
		instance.mobile = validated_data.get("mobile", instance.mobile)
		instance.email = validated_data.get("email", instance.email)
		instance.profile = validated_data.get("profile_picture", instance.profile_picture)

		if instance.is_admin :
			obj = Organization.objects.get(account=instance)
			obj.address = validated_data.get("address", obj.address)
			obj.save()

		elif instance.is_staff :
			obj = Staff.objects.get(account=instance)
			obj.address = validated_data.get("address", obj.address)
			obj.save()

		elif instance.is_teacher :
			obj = Teacher.objects.get(account=instance)
			obj.address = validated_data.get("address", obj.address)
			obj.save()
		
		else :
			obj = Student.objects.get(account=instance)
			obj.address = validated_data.get("address", obj.address)
			obj.save()
		instance.save()
		print(instance)
		return instance





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
			

			instance.save()
			return instance


class BatchSerializer(serializers.ModelSerializer):

	class Meta:
		model = Batch
		fields = [
			"pk",
			"name",

			"title",
			"fee",
			"image",
			"description",
			"is_active",
			"discount",
			"organization",
			"created_at",
			"updated_at"
		]
		extra_kwargs = {
				'organization': {'write_only': True},
		}



class StudentRegitrationSerializer(serializers.ModelSerializer):

	password2 				= serializers.CharField(style={'input_type': 'password'}, write_only=True)
	batch 					= serializers.IntegerField(allow_null=False, required=True)
	address 				= serializers.CharField(required=False)
	group 					= serializers.CharField(required=False)
	balance 				= serializers.DecimalField(max_digits=10, decimal_places=2, required=True)

	parent_mobile 			= serializers.CharField(allow_null=False, required=True)
	registration_number 	= serializers.CharField(allow_null=False, required=True)

	hsc_group 				= serializers.CharField(required=False)
	hsc_year 				= serializers.CharField(required=False)
	hsc_roll 				= serializers.CharField(required=False)
	hsc_gpa 				= serializers.CharField(required=False)

	ssc_group 				= serializers.CharField(required=False)
	ssc_year 				= serializers.CharField(required=False)
	ssc_roll 				= serializers.CharField(required=False)
	ssc_gpa 				= serializers.CharField(required=False)
	
	

	class Meta:
		model = Account
		fields = [
			'email',
			'username',
			'mobile',
			'profile_picture',
			'password',
			'password2',


			'balance',
			'batch',
			'address',
			"group",

			"parent_mobile",
			"registration_number",

			"hsc_group",
			"hsc_year",
			"hsc_roll",
			"hsc_gpa",

			"ssc_group",
			"ssc_year",
			"ssc_roll",
			"ssc_gpa"	
			]
		extra_kwargs = {
				'password': {'write_only': True},
		}	


	def	save(self):

		organization = self.context.get("organization")
		try:
			batch = Batch.objects.get(pk = self.validated_data.get("batch", None))
		except:
			data = {}
			data["response"] = "Error"
			data["error_message"] = "Batch not found"
			raise serializers.ValidationError(data)

		parent_mobile = self.validated_data.get("parent_mobile", None)
		if not parent_mobile :
			data = {}
			data["response"] = "Error"
			data["error_message"] = "Parent mobile required"
			raise serializers.ValidationError(data)

		registration_number = self.validated_data.get("registration_number", None)
		if not registration_number :
			data = {}
			data["response"] = "Error"
			data["error_message"] = "Registration number required"
			raise serializers.ValidationError(data)
		
		hsc_group = self.validated_data.get("hsc_group", None)
		hsc_year = self.validated_data.get("hsc_year", None)
		hsc_roll = self.validated_data.get("hsc_roll", None)
		hsc_gpa = self.validated_data.get("hsc_gpa", None)

		ssc_group = self.validated_data.get("ssc_group", None)
		ssc_year = self.validated_data.get("ssc_year", None)
		ssc_roll = self.validated_data.get("ssc_roll", None)
		ssc_gpa = self.validated_data.get("ssc_gpa", None)

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
		

		student = Student(
				account=account,
				organization = organization,
				balance = self.validated_data.get("balance", 0.00),
				batch = batch,
				address = self.validated_data.get("address", None),
				group = self.validated_data.get("group", None),
				parent_mobile = parent_mobile,
				registration_number = registration_number,
				hsc_group = hsc_group,
				hsc_year = hsc_year,
				hsc_roll = hsc_roll,
				hsc_gpa = hsc_gpa,
				ssc_group = ssc_group,
				ssc_year = ssc_year,
				ssc_roll = ssc_roll,
				ssc_gpa = ssc_gpa
			)
		student.save()
		return account



	
class StudentUpdateSerializer(serializers.ModelSerializer):

	address 				= serializers.CharField(required=False)
	batch 					= serializers.IntegerField(allow_null=True, required=False)
	address 				= serializers.CharField(required=False)
	group 					= serializers.CharField(required=False)


	parent_mobile 			= serializers.CharField(allow_null=False, required=True)
	registration_number 	= serializers.CharField(allow_null=False, required=True)

	hsc_group 				= serializers.CharField(required=False)
	hsc_year 				= serializers.CharField(required=False)
	hsc_roll 				= serializers.CharField(required=False)
	hsc_gpa 				= serializers.CharField(required=False)

	ssc_group 				= serializers.CharField(required=False)
	ssc_year 				= serializers.CharField(required=False)
	ssc_roll 				= serializers.CharField(required=False)
	ssc_gpa 				= serializers.CharField(required=False)
	

	class Meta:
		model = Account
		fields = [
			'email',
			'username',
			'mobile',
			'profile_picture',
			
			'batch',
			'address',
			"group",



			"parent_mobile",
			"registration_number",

			"hsc_group",
			"hsc_year",
			"hsc_roll",
			"hsc_gpa",

			"ssc_group",
			"ssc_year",
			"ssc_roll",
			"ssc_gpa"
			]	

	def update(self, instance, validated_data):
		student = Student.objects.get(account=instance)

		instance.email = validated_data.get("email", instance.email)
		instance.username = validated_data.get("username", instance.username)
		instance.mobile = validated_data.get("mobile", instance.mobile)
		instance.profile_picture = validated_data.get("profile_picture", instance.profile_picture)

		batch_pk = validated_data.get("batch", None)
		if batch_pk != None:
			if Batch.objects.filter(pk=batch_pk).exists():
				student.batch = Batch.objects.get(pk=batch_pk)
			else:
				raise serializers.ValidationError({'response': 'Error', "error_message": "batch not found"})

		parent_mobile = validated_data.get("parent_mobile", None)
		if not parent_mobile :
			data = {}
			data["response"] = "Error"
			data["error_message"] = "Parent mobile required"
			raise serializers.ValidationError(data)
		student.parent_mobile = parent_mobile

		registration_number = validated_data.get("registration_number", None)
		if not registration_number :
			data = {}
			data["response"] = "Error"
			data["error_message"] = "Registration number required"
			raise serializers.ValidationError(data)
		

		student.registration_number = registration_number
		
		student.hsc_group = validated_data.get("hsc_group", student.hsc_group)
		student.hsc_year = validated_data.get("hsc_year", student.hsc_year)
		student.hsc_roll = validated_data.get("hsc_roll", student.hsc_roll)
		student.hsc_gpa = validated_data.get("hsc_gpa", student.hsc_gpa)

		student.ssc_group = validated_data.get("ssc_group", student.ssc_group)
		student.ssc_year = validated_data.get("ssc_year", student.ssc_year)
		student.ssc_roll = validated_data.get("ssc_roll", student.ssc_roll)
		student.ssc_gpa = validated_data.get("ssc_gpa", student.ssc_gpa)
			
		student.address = validated_data.get("address", student.address)
		student.group = validated_data.get("group", student.group)
		student.save()
		


		instance.save()
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
			







			instance.save()
			return instance



class StaffSerializer(serializers.ModelSerializer):

	address 					= serializers.CharField(required=False)
	account_pk 					= serializers.SerializerMethodField("get_account_pk")
	email 						= serializers.SerializerMethodField("get_email")
	mobile 						= serializers.SerializerMethodField("get_mobile")
	username 					= serializers.SerializerMethodField("get_username")
	profile_picture 			= serializers.SerializerMethodField("get_profile_picture")


	class Meta:
		model = Staff
		fields = [
			'pk',
			'account_pk',
			'email',
			'username',
			'mobile',
			'profile_picture',
			'address',
			'balance',
			'created_at',
			'updated_at'
			]

	def get_email(self, obj):
		return obj.account.email

	def get_mobile(self, obj):
		return obj.account.mobile

	def get_username(self, obj):
		return obj.account.username

	def get_profile_picture(self, obj):
		if obj.account.profile_picture:
			# return get_photo_url(self, obj)
			return obj.account.profile_picture.url
		else:
			return None





	
	def get_account_pk(self, obj) :
		return obj.account.pk


class StudentSerializer(serializers.ModelSerializer):

	address 					= serializers.CharField(required=False)
	account_pk 					= serializers.SerializerMethodField("get_account_pk")
	email 						= serializers.SerializerMethodField("get_email")
	mobile 						= serializers.SerializerMethodField("get_mobile")
	username 					= serializers.SerializerMethodField("get_username")
	profile_picture 			= serializers.SerializerMethodField("get_profile_picture")
	is_active					= serializers.SerializerMethodField("get_is_activate")
	batch_name 					= serializers.SerializerMethodField("get_batch_name")


	class Meta:
		model = Student
		fields = [
			'pk',
			'account_pk',
			'email',
			'username',
			'mobile',
			'profile_picture',
			'address',
			'balance',
			'batch',
			"batch_name",
			"is_active",
			"group",

			"parent_mobile",
			"registration_number",

			"hsc_group",
			"hsc_year",
			"hsc_roll",
			"hsc_gpa",

			"ssc_group",
			"ssc_year",
			"ssc_roll",
			"ssc_gpa",

			'created_at',
			'updated_at'
			]

	# def get_pk(self, obj):
	# 	return obj.account.pk

	def get_email(self, obj):
		return obj.account.email

	def get_mobile(self, obj):
		return obj.account.mobile

	def get_username(self, obj):
		return obj.account.username

	def get_profile_picture(self, obj):
		if obj.account.profile_picture:
			# return get_photo_url(self, obj)


			return obj.account.profile_picture.url
		else:
			return None
	
	def get_is_activate(self, obj):
		return obj.account.is_active

	def get_batch_name(self, obj):
		if obj.batch:
			return obj.batch.name
		else:
			return None

	def get_account_pk(self, obj) :
		return obj.account.pk


class TeacherSerializer(serializers.ModelSerializer):

	address 					= serializers.CharField(required=False)
	account_pk 					= serializers.SerializerMethodField("get_account_pk")
	email 						= serializers.SerializerMethodField("get_email")
	mobile 						= serializers.SerializerMethodField("get_mobile")
	username 					= serializers.SerializerMethodField("get_username")
	profile_picture 			= serializers.SerializerMethodField("get_profile_picture")


	class Meta:
		model = Teacher
		fields = [
			'pk',







			'account_pk',
			'email',
			'username',
			'mobile',
			'profile_picture',
			'address',
			'balance',
			'created_at',
			'updated_at'
			]

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


	
	def get_account_pk(self, obj) :
		return obj.account.pk





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