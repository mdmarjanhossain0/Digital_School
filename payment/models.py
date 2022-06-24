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





class StaffPayment(models.Model):

	organization                = models.ForeignKey(Organization, on_delete=models.CASCADE)
	staff                     	= models.ForeignKey(Staff, on_delete=models.CASCADE)
	note 						= models.TextField(null=True, blank=True)
	fee 	                 	= models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
	fine 						= models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
	discount 					= models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
	created_at                  = models.DateTimeField(verbose_name="created_at", auto_now_add=True)
	updated_at                  = models.DateTimeField(verbose_name="updated_at", auto_now=True)

	
class StudentPayment(models.Model):

	organization                = models.ForeignKey(Organization, on_delete=models.CASCADE)
	student                     = models.ForeignKey(Student, on_delete=models.CASCADE)
	note 						= models.TextField(null=True, blank=True)
	fee 	                 	= models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
	fine 						= models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
	discount 					= models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
	created_at                  = models.DateTimeField(verbose_name="created_at", auto_now_add=True)
	updated_at                  = models.DateTimeField(verbose_name="updated_at", auto_now=True)


class TeacherPayment(models.Model):

	organization                = models.ForeignKey(Organization, on_delete=models.CASCADE)
	teacher                     = models.ForeignKey(Teacher, on_delete=models.CASCADE)
	note 						= models.TextField(null=True, blank=True)
	fee 	                 	= models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
	fine 						= models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
	discount 					= models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
	created_at                  = models.DateTimeField(verbose_name="created_at", auto_now_add=True)
	updated_at                  = models.DateTimeField(verbose_name="updated_at", auto_now=True)






class OtherPayment(models.Model):

	organization                = models.ForeignKey(Organization, on_delete=models.CASCADE)
	note 						= models.TextField(null=True, blank=True)
	fee 	                 	= models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
	fine 						= models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
	discount 					= models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
	created_at                  = models.DateTimeField(verbose_name="created_at", auto_now_add=True)
	updated_at                  = models.DateTimeField(verbose_name="updated_at", auto_now=True)