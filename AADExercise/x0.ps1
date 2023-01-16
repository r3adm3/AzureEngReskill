
#function here doesn't execute unless called
function addTwoNumbers {
    #here we collect our parameters
    param(
        $number1,
        $number2
    )

    $result = $number1 + $number2
    write-output $result
}

# here we start executing the script. 
write-output "First function call answer (1+2):"
addTwoNumbers -number1 1 -number2 2 

#or

$callmyFunction = addTwoNumbers -number1 2 -number2 3

write-output "Second answer is (2+3): $callmyFunction" 