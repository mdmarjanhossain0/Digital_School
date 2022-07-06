import email
from django.db import models

from account.models import (
	Account,
	Organization,
	Staff,
	Batch,
	Student,
	Teacher
)




class Course(models.Model):

	organization                = models.ForeignKey(Organization, on_delete=models.CASCADE)
	name                        = models.CharField(max_length=100)
	is_available 				= models.BooleanField(default=True)
	description 				= models.TextField(null=True, blank=True)
	created_at                  = models.DateTimeField(verbose_name="created_at", auto_now_add=True)
	updated_at                  = models.DateTimeField(verbose_name="updated_at", auto_now=True)



class Exam(models.Model):

	organization                = models.ForeignKey(Organization, on_delete=models.CASCADE)
	batch                       = models.ForeignKey(Batch, on_delete=models.SET_NULL, null=True, blank=True)
	courses 					= models.ManyToManyField(Course)
	name                        = models.CharField(max_length=100)
	schedule 					= models.DateTimeField(null=True, blank=True)
	created_at                  = models.DateTimeField(verbose_name="created_at", auto_now_add=True)
	updated_at                  = models.DateTimeField(verbose_name="updated_at", auto_now=True)

	def __str__(self):
		return str(self.pk)

class Result(models.Model):

	organization                = models.ForeignKey(Organization, on_delete=models.CASCADE)
	exam 						= models.ForeignKey(Exam, on_delete=models.CASCADE)
	student 					= models.ForeignKey(Student, on_delete=models.CASCADE)
	course 						= models.ForeignKey(Course, on_delete=models.SET_NULL, null=True, blank=True)
	mark 						= models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
	created_at                  = models.DateTimeField(verbose_name="created_at", auto_now_add=True)
	updated_at                  = models.DateTimeField(verbose_name="updated_at", auto_now=True)

	# class Meta:
	# 	unique_together = ('exam', 'student', 'course')