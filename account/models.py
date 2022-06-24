from re import T
from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager
from django.conf import settings
from django.db.models.signals import post_save
from django.dispatch import receiver
from rest_framework.authtoken.models import Token





from django.dispatch import receiver
from django.urls import reverse
from django.core.mail import send_mail 


class MyAccountManager(BaseUserManager):

	def create_user(self, mobile, username, password=None):
		if not mobile:
			raise ValueError("User must have an phone number")
		if not username:
			raise ValueError("User must have an username address")

		user = self.model(
			username=username,
			mobile=mobile
		)
		user.set_password(password)
		user.save(using=self._db)
		return user

	def create_superuser(self, mobile, username, password):


		# if not email:
		# 	raise ValueError('Users must have an email address')
			
		if not mobile:
			raise ValueError("User must have an phone number")
		if not username:
			raise ValueError("User must have an username address")

		user = self.create_user(
			mobile=mobile,
			username=username
		)
		user.set_password(password)
		user.is_admin = True
		user.is_staff = True
		user.is_superuser = True
		user.save(using=self._db)
		return user


def profile_picture_location(instance, filename):
	file_path = '{mobilewithusername}/pp/{filename}'.format(
		filename=filename,
		mobilewithusername = instance.username + instance.mobile
	)
	return file_path



class Account(AbstractBaseUser):
	email                       = models.EmailField(verbose_name="email", max_length=60, null=True, blank=True)
	mobile                      = models.CharField(max_length=15, unique=True, verbose_name='mobile')
	username                    = models.CharField(max_length=32, unique=True)
	profile_picture             = models.ImageField(upload_to=profile_picture_location, null=True, blank=True)
	date_joined                 = models.DateTimeField(verbose_name="date_joined", auto_now_add=True)
	last_login                  = models.DateTimeField(verbose_name="last_login", auto_now=True)
	otp                         = models.CharField(max_length=6, null=True, blank=True)
	is_admin                    = models.BooleanField(default=False)
	is_active                   = models.BooleanField(default=True)
	is_staff                    = models.BooleanField(default=False)
	is_superuser                = models.BooleanField(default=False)
	is_teacher                  = models.BooleanField(default=False)

	USERNAME_FIELD = 'mobile'
	REQUIRED_FIELDS = ["username", ]

	objects = MyAccountManager()

	def __str__(self):
		return self.username + self.mobile

	def has_perm(self, perm, obj=None):
		return self.is_admin

	def has_module_perms(self, app_level):
		return True


class Organization(models.Model):





	account                     = models.OneToOneField(Account, on_delete=models.CASCADE)
	organization_name           = models.CharField(max_length=150, unique=True)
	address                     = models.CharField(max_length=150, null=True, blank=True)







class Staff(models.Model):

	account                     = models.OneToOneField(Account, on_delete=models.CASCADE)
	organization                = models.ForeignKey(Organization, on_delete=models.CASCADE)
	balance                     = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
	address                     = models.CharField(max_length=15, null=True, blank=True)
	created_at                  = models.DateTimeField(verbose_name="created_at", auto_now_add=True)
	updated_at                  = models.DateTimeField(verbose_name="updated_at", auto_now=True)
	

class Batch(models.Model):
	organization                = models.ForeignKey(Organization, on_delete=models.CASCADE)
	name                        = models.CharField(max_length=32, null=False, blank=False)
	created_at                  = models.DateTimeField(verbose_name="created_at", auto_now_add=True)
	updated_at                  = models.DateTimeField(verbose_name="updated_at", auto_now=True)


class Student(models.Model):
	account                     = models.OneToOneField(Account, on_delete=models.CASCADE)
	organization                = models.ForeignKey(Organization, on_delete=models.CASCADE)
	balance                     = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
	batch                       = models.ForeignKey(Batch, null=True, blank=True, on_delete=models.SET_NULL)
	address                     = models.CharField(max_length=150, null=True, blank=True)
	group 						= models.CharField(max_length=100, null=True, blank=True)
	created_at                  = models.DateTimeField(verbose_name="created_at", auto_now_add=True)
	updated_at                  = models.DateTimeField(verbose_name="updated_at", auto_now=True)







class Teacher(models.Model):
	account                     = models.OneToOneField(Account, on_delete=models.CASCADE)
	organization                = models.ForeignKey(Organization, on_delete=models.CASCADE)
	balance                     = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
	address                     = models.CharField(max_length=150, null=True, blank=True)
	created_at                  = models.DateTimeField(verbose_name="created_at", auto_now_add=True)
	updated_at                  = models.DateTimeField(verbose_name="updated_at", auto_now=True)


@receiver(post_save, sender=settings.AUTH_USER_MODEL)
def create_auth_token(sender, instance=None, created=False, **kwargs):
	if created:
		Token.objects.create(user=instance)