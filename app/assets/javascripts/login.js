$(document).on('turbolinks:load', function() {
  function openSignupForm() {
    var loginFormToggle = $('#log-tab');
    var signupFormToggle = $('#profile-tab');
    var loginForm = $('.accountbox__login');
    var signupForm = $('.accountbox__register');
    signupFormToggle.on('click', function() {
      $(this).addClass('active');
      loginFormToggle.removeClass("active");
      loginForm.removeClass('show');
      signupForm.addClass('show');
      $('.accountbox__options').removeClass("show");
    });
    loginFormToggle.on('click', function() {
      $(this).addClass('active');
      signupFormToggle.removeClass("active");
      loginForm.addClass('show');
      signupForm.removeClass("show");
      $('.accountbox__options').removeClass("show");
    });
  }
  openSignupForm();
})
