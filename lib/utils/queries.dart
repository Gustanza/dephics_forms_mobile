// auth quries
const sendOTPQ = '''
    mutation(\$phoneNumber: String!) {
      otp(input:{username: \$phoneNumber,usernameType:phone}) {
        status,
        message
      }
    }
''';

const logOTPQ = '''
    mutation Login(\$input: LoginInput!) {
      login(input: \$input) {
        accessToken
        refreshToken
      }
    }
''';

const fvisitsQ = '''
query{
  child_data:fieldVisitSummary{
    count
  }
}
''';
