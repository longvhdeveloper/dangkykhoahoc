class StudentsController < ApplicationController
  def index
  end

  def register
    @student = Student.new
  end

  def signup
    @student = Student.new(:email => student_params[:email], :password => student_params[:password])
    if @student.save
      redirect_to '/index'
    else
      render :register
    end
  end

  def login
    if request.post?
      do_login
    else
      render :login
    end
  end

  private

  def do_login
    if Student.login_by_email_and_password(params[:email], params[:password])
      flash[:notice] = 'Login success'
      session[:logined_email] = params[:email]
      redirect_to '/students'
    else
      flash[:notice] = 'Login failed'
      redirect_to '/login'
    end
  end

  def student_params
    params.require(:student).permit(:email, :password)
  end

end
