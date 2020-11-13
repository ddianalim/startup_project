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
        @salaries.keys.include?(title)
    end

    def >(startup)
        self.funding > startup.funding
    end

    def hire(employee_name, title)
        if !valid_title?(title)
            return error
        else
            @employees << Employee.new(employee_name, title)
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        total_funding = 0
        @salaries.each_value { |salary| total_funding += salary}

        if funding > total_funding
            employee_salary = @salaries[employee.title]
            employee.pay(employee_salary)
            funding -= employee_salary
        else
            return error
        end
    end

    def payday
        @employees.each do |employee|
            pay_employee(employee)
        end
    end
end
