enum UserStatus {
  newUser('NEW_USER'),
  documentUploadStarted('DOCUMENT_UPLOAD_STARTED'),
  verificationInProgress('VERIFICATION_IN_PROGRESS'),
  verificationCompleted('VERIFICATION_COMPLETED'),
  fullyVerified('FULLY_VERIFIED'),
  verificationRejected('VERIFICATION_REJECTED'),
  userDeleted('USER_DELETED');

  const UserStatus(this.value);

  final String value;
}
