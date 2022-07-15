from django.db import models

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





def notifiacation_image_location(instance, filename):
	file_path = '{mobilewithusername}/notification/{filename}'.format(
		filename=filename,
		mobilewithusername = instance.organization.account.username + instance.organization.account.mobile
	)
	return file_path

class Notification(models.Model) :
	organization                    = models.ForeignKey(Organization, on_delete=models.CASCADE)
	title                           = models.CharField(max_length=100)
	description                     = models.TextField()
	reads 							= models.ManyToManyField(Account)
	image                           = models.ImageField(upload_to=notifiacation_image_location, null=True, blank=True)
	created_at                  	= models.DateTimeField(verbose_name="created_at", auto_now_add=True)
	updated_at                  	= models.DateTimeField(verbose_name="updated_at", auto_now=True)