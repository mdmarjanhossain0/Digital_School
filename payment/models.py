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

	
class Payment(models.Model):

	organization                = models.ForeignKey(Organization, on_delete=models.CASCADE)
	account                     = models.ForeignKey(Account, on_delete=models.SET_NULL, null=True, blank=True)
	note 						= models.TextField(null=True, blank=True)
	# type 						= models.CharField(max_length=100, default="")
	fee 	                 	= models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
	fine 						= models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
	discount 					= models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
	created_at                  = models.DateTimeField(verbose_name="created_at", auto_now_add=True)
	updated_at                  = models.DateTimeField(verbose_name="updated_at", auto_now=True)


class Payments(models.Model):

	organization                = models.ForeignKey(Organization, on_delete=models.CASCADE)
	account                     = models.ForeignKey(Account, on_delete=models.SET_NULL, null=True, blank=True)
	note 						= models.TextField(null=True, blank=True)
	type 						= models.CharField(max_length=100)
	fee 	                 	= models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
	fine 						= models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
	discount 					= models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
	# payment_by 					= models.ForeignKey(Account, on_delete=models.SET_NULL, null=True, blank=True)
	created_at                  = models.DateTimeField(verbose_name="created_at", auto_now_add=True)
	updated_at                  = models.DateTimeField(verbose_name="updated_at", auto_now=True)