from account.models import Account



def validate_mobile(mobile):
	account = None
	try:
		account = Account.objects.get(mobile=mobile)
	except Account.DoesNotExist:
		return None
	if account != None:
		return mobile

def validate_email(email):
	account = None
	try:
		account = Account.objects.get(email=email)
	except Account.DoesNotExist:
		return None
	if account != None:
		return email

def validate_username(username):
	account = None
	try:
		account = Account.objects.get(username=username)
	except Account.DoesNotExist:
		return None
	if account != None:
		return username