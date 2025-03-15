
1. Servlet Filters →
- Servlet Filters can route web requests based on security logic
[eg - sending back to login page if credentials denied]
- Spring provides a bulk of security functionality with servlet filters. Eg - session based security,
authentication, BearerTokenAuthenticationFilter, CsrfFilter, etc

2. Dependency - spring-boot-starter-security
- By using the above dependency - your endpoints are automatically secured.
- When you try to access your application, the default username will be - “user” and
password will be provided at the end of your console screen in IntelliJ.
- You can override the default username and pass -
        spring.security.user.name=scott
        spring.security.user.password=tiger

------------[I] STARTS NOOP IN-MEMORY-------------

A. Create the mysql schema and enter dummy values in it using MySQL.sql file given.

B. Create a class - DemoSecurityConfig.java inside the security package

C. Inside this class we have stored the user, pass and role "in memory" rather than in DB.
- Let's say we have some more users
    USER ID     PASSWORD         ROLES
    john        test123         EMPLOYEE
    marry       test123         EMPLOYEE, MANAGER
    susan       test123         EMPLOYEE, MANAGER, ADMIN

C. In this class DemoSecurityConfig we will give the access based on roles - lets say -
    Employee    - R
    Manager     - CRU
    Admin       - CRUD

D. CSRF Disbled. Why?
Ans - CSRF (Cross-Site Request Forgery) is a security feature in Spring Security that
        protects your application from malicious attacks where an attacker tricks users
        into performing actions they didn't intend to.

        In general, CSRF not required for stateless REST APIs.

        A stateless API means that the server does not store any client-related session information.

      🚨 Disabling CSRF
      When you disable CSRF, your API no longer requires a CSRF token.
      This is usually done for stateless REST APIs, where authentication is done via JWT
      or Basic Auth instead of sessions.

E. In postman login using authorization -
    -user = john and pass = test 123 and hit the link -
    GET - http://localhost:8080/api/employees
    or
    GET - http://localhost:8080/api/employees/1

E. John is Employee Only so if you try below - access will be denied -
    POST - http://localhost:8080/api/employees
    With JSON DATA -
    {
      "firstName": "Alice",
      "lastName": "Green",
      "email": "alice.green@example.com"
    }
    Output - The 403 Forbidden error means that authentication was successful,
    but the user does not have permission to perform the action.

F. Change Authorization to -
    user = mary and pass = test123
    And repeat the above for user creation link and json data. SUCCESS

G. Update using Mary account -
    PUT - http://localhost:8080/api/employees
    JSON -
    {
       "id" : 1,
      "firstName": "honey",
      "lastName": "paliwal",
      "email": "honey.paliwal@example.com"
    }
    OUTPUT - SUCCESS

H. Delete Using mary account -
    DELETE - http://localhost:8080/api/employees/1
    Output - 403Forbidden - authentication was successful, but the user does not have permission to perform the action.

I. Delete using susan account
    DELETE - http://localhost:8080/api/employees/1
    Output - Deleted employee id - 1

------------[I] ENDS NOOP IN-MEMORY-------------

------------[II] STARTS NOOP IN-MySQL DB-------------
A. Run the DB query as mentioned in the 2.MySQLUserAuthorityNOOP.sql file
B. In this case - inside DemoSecurityConfig.java - Just replace one bean
    i.e. In memory bean [I have commented this out] with JDBC bean as shown below -
    @Bean
    public UserDetailsManager userDetailsManager(DataSource dataSource) {
       return new JdbcUserDetailsManager(dataSource);
    }
C. Similarly you can test the above links eg -
    user = susan, pass = test123
    GET - http://localhost:8080/api/employees

------------[II] ENDS NOOP IN-MySQL DB-------------

------------[III] STARTS BCRYPT IN-MySQL DB-------------
A. Use the website "https://bcrypt.online/" to get the bcrypt hashed password.
    [Note - For same password if bcryt is generated again and again, every hash will be different]
B. How bcrypt understands the password?
Ans - Bcrypt is a one-way hashing algorithm, meaning
    it does not decrypt passwords. Instead, it uses a hashing and verification
    process to check if a password is correct. Here’s how it works.
    When the user logs in, the provided password is hashed again with the same salt.
    Bcrypt does not decrypt the stored hash. Instead, it re-hashes the input and compares it.
C. Drop the old schema and create new schema "3.MySQLUserAuthorityBCRYPT.sql" given file.
    NOTE - all the 3 hash are different in the DB query for password but the password
    is same for all - fun123
D. Now when the user login using the password fun123 - it need to be bcryted again and then
    this bcrypted password will be compared with the bcrypted password present in the DB.
    If both matches then the password is same and correct so the user will be logged in.
    We used this for this particular task - Spring automatically understands it -
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
    For this -
    - Modify the "UserDetailsManager" bean present in the DemoSecurityConfig.java class.
    - You can also compare the enocded password generated by sysout in console on website with "fun123"
E. Again test the endpoints with -
    user = susan, pass = fun123
    GET - http://localhost:8080/api/employees
