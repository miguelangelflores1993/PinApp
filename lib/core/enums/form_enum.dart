enum FormStatus {
  initial('initial'),
  loading('loading'),
  loadingComments('loadingComments'),
  loaded('loaded'),
  submitSuccess('submit'),
  submitFormSuccess('submitForm'),
  submitCancelled('submit'),
  error('error');

  const FormStatus(this.status);

  final String status;
}
