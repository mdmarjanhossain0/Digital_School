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





class StudentFee(models.Model):

	organization                = models.ForeignKey(Organization, on_delete=models.CASCADE)
	student                     = models.ForeignKey(Student, on_delete=models.CASCADE)
	monthly_fee                 = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
	created_at                  = models.DateTimeField(verbose_name="created_at", auto_now_add=True)
	updated_at                  = models.DateTimeField(verbose_name="updated_at", auto_now=True)