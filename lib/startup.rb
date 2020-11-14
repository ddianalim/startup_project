require "employee"
require "byebug"
class Startup
    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        # @salaries.keys.include?(title)
        @salaries.has_key?(title)
    end

    def >(startup)
        self.funding > startup.funding
    end

    def hire(employee_name, title)
        if valid_title?(title)
            @employees << Employee.new(employee_name, title)
        else
            raise "title is not valid!"
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        employee_salary = @salaries[employee.title]
        if @funding >= employee_salary
            employee.pay(employee_salary)
            @funding -= employee_salary
        else
            raise "not enough funding to pay employee!"
        end
    end

    def payday
        @employees.each { |employee| self.pay_employee(employee) }
    end

    def average_salary
        total = 0
        @employees.each do |employee|
            total += @salaries[employee.title]
        end
        total / @employees.size
    end
    
    def close
        @employees = []
        @funding = 0
    end

    def acquire(new_startup)
        @funding += new_startup.funding
        new_startup.salaries.each do |title, salary| 
            if !@salaries.has_key?(title)
                @salaries[title] = salary
            end
        end
        @employees += new_startup.employees
        # new_startup.employees.each do |employee|
        #     @employees << employee
        # end
        new_startup.close
    end
end
