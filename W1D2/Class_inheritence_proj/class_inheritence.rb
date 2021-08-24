
class Employee
   attr_reader :name, :title, :salary
   attr_accessor :boss 
    def initialize(name, title, salary, boss = nil)
        @name = name
        @title = title
        @salary = salary
        self.boss = boss
    end

    def boss=(boss)
        @boss = boss

        boss.add_employee(self) unless boss.nil?

        boss
    end

    def bonus(multiplyer)
        self.salary * multiplyer
    end

end

class Manager < Employee
    attr_reader :employees
    def initialize(name, title, salary, boss = nil)
        super(name, title, salary, boss)

        @employees = []
    end

    def add_employee(employee)
        employees << employee

        employee
    end

    def bonus(multiplyer)
        self.total_sub_salary * multiplyer
    end

    def total_sub_salary
        total_sum_sub = 0

        self.employees.each do |employee|
         if employee.is_a?(Manager)
            total_sum_sub += employee.salary + employee.total_sub_salary
         else
            total_sum_sub += employee.salary
         end
        end

        total_sum_sub

    end


end

    

