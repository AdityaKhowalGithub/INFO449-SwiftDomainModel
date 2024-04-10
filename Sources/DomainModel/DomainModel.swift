struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
// To start, you will need to create a Money type (a struct). It will need two properties, `amount` and `currency`, since money is different in different cultures. (We will be ignoring fractional amounts like pennies for simplicity's sake; round up or down to the appropriate whole number when working with a fractional amount.) The `amount` should be an Int and the `currency` should be a String--make sure to include code to reject unknown currencies. Acceptable currencies are "USD", "GBP" (British pounds), "EUR" (Euro) and "CAN" (Canadian dollars, also known in the US as "funny money").

//Money should also have three methods, `convert`, which takes a currency name as a parameter and returns a new Money that contains the converted amount, and `add` and `subtract`, which each take a Money as a parameter and returns a new Money that contains the addition or subtraction of the two. Note that it is entirely acceptable to add mixed-currency amounts (5 EUR to 7 USD, and so on).
//
//Exchange rates are as follows:
//
//* 1 USD = .5 GBP / 2 USD = 1 GBP
//
//* 1 USD = 1.5 EUR / 2 USD = 3 EUR
//
//* 1 USD = 1.25 CAN / 4 USD = 5 CAN

public struct Money {
    var amount: Int
    var currency: String
    
    private let acceptable_currencies = ["USD", "GBP", "EUR", "CAN"]
    
    private let exchange_rates: [String: [String: Double]] = [
            "USD": ["GBP": 0.5, "EUR": 1.5, "CAN": 1.25],
            "GBP": ["USD": 2.0, "EUR": 3.0, "CAN": 2.5],
            "EUR": ["USD": 0.66667, "GBP": 0.33333, "CAN": 0.83333],
            "CAN": ["USD": 0.8, "GBP": 0.4, "EUR": 1.2]
        ]
    
    init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }
    
    func convert(_ newCurrency: String) -> Money{
        if !acceptable_currencies.contains(newCurrency)
        {return self}
        
        return Money(
            amount: Int(Double(amount) * (exchange_rates[currency]?[newCurrency] ?? 1.0)),
            currency: newCurrency
        )
    }
    func add(_ m: Money) -> Money{
        return Money(
            amount:
                m.convert(self.currency).amount + self.amount,
            currency:
                self.currency
        ).convert(m.currency)
    }
    func subtract(_ m: Money) -> Money{
        return Money(
            amount:
                m.convert(self.currency).amount - self.amount,
            currency:
                self.currency
        ).convert(m.currency)

    }
    
    
}

////////////////////////////////////
// Job
//How do we get money? From jobs, of course! Create a class, called Job, that has two properties: `title`, a String describing the name of the job, and `type`, which will be an enumeration called JobType (which is already provided for you). Note that the JobType is a "discriminated union", meaning it is an enumeration that can carry data--in this case, the amount of either the Hourly wage (a Double) or the yearly Salary amount (an Int).
//
//The two methods you must provide are:
//
//* `calculateIncome`, which returns the amount of money (as an Integer, we're not worried about Money here) that this position makes in a calendar year. For Salary positions, this is simply the yearly amount; for Hourly positions, this is the hourly amount multiplied by 2000. (Interesting and important note for job seekers: assuming you get two weeks' off during the year, there are 50 weeks * 40 hours/week, or 2000 working hours in a given calendar year.)
//
//* `raise`, which should bump the amount of the Salary or the Hourly by the given amount, and/or by the given percentage. (In other words, `raise` should be overloaded by parameter name.)
//
//All of the Job tests are in JobTests.swift, if you want to see what's tested
public class Job {
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
    var title: String
    var type: JobType
    init(title: String, type: JobType) {
        self.title = title
        self.type = type
    }
    func calculateIncome(_ hoursWorked: Int) -> Int {
        if case.Hourly(let rate) = type {
            return Int(
                Double(hoursWorked) * rate
            )
        }else if case.Salary(let uInt) = type {
            return Int(uInt)
        }else{
            return 0
        }
    }
    
    func raise(byAmount: Double){
        switch type {
        case .Hourly(let hour):
            type = JobType.Hourly(
                hour + Double(byAmount)
            )
        case .Salary(let year):
            type = JobType.Salary(
                year + UInt(byAmount)
            )
        }
    }
    
    func raise(byPercent: Double){
        switch type {
        case .Hourly(let hour):
            type = JobType.Hourly(
                hour * (1.0 + byPercent)
            )
        case .Salary(let year):
            type = JobType.Salary(
                UInt(
                    Double(year) * (1.0 + byPercent)
                )
            )
        }
        
    }
}

////////////////////////////////////
// Person
//Now we want to start modeling those carbon-based life forms that do jobs, a la people. Create a class, called Person, which will have the following five properties:
//
//* `firstName` and `lastName`, both Strings
//
//* `age`, an Int
//
//* `job`, a Job (the rough syntax for the property is provided for you)
//
//* `spouse`, a Person (the rough syntax for the property is provided for you)
//
//Note that `job` and `spouse` are nullable, whereas the others aren't.
//
//Create an initializer to take the first three as parameters; since `job` and `spouse` are not always present (not everyone has a job, and certainly not everyone is married), leave those out of the initializer.
//
//Create a method to display a human-readable String of the contents of a Person. (Since so many of you--and me--are all comfortable with Java, call it `toString`.) Put some reasonable display of the Person class there, along the lines of `[Person: firstName: Ted lastName: Neward age: 45 job: Salary(1000) spouse: Charlotte]`.
//
//All of the Person tests are in PersonTests.swift, if you want to see what's tested.
public class Person {
    
}

////////////////////////////////////
// Family
//
public class Family {
}
