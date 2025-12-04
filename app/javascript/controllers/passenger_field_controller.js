import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "template" ]

    add() {
        if (this.numPassengers < 4) {
            const clone = document.importNode(this.templateTarget.content, true)
            
            // add field container label 
            clone.querySelector("b").innerText = `Passenger ${this.numPassengers + 1}: `
            
            // add indexed nested field attributes
            const fieldList = clone.querySelectorAll("li > *")
            const dateIndex = Date.now()

            for (let i = 0; i < fieldList.length; i++) {
                // set name label element
                if (fieldList[i].innerText == "Name") {
                    fieldList[i].setAttribute("for", `booking_passengers_attributes_${dateIndex}_name`)
                }

                // set name input element
                if (fieldList[i].getAttribute("name") !== null && fieldList[i].getAttribute("name").includes("name")) {
                    fieldList[i].setAttribute("name", `booking[passengers_attributes][${dateIndex}][name]`)
                    fieldList[i].setAttribute("id", `booking_passengers_attributes_${dateIndex}_name`)
                }

                // set email label element
                if (fieldList[i].getAttribute("name") !== null && fieldList[i].getAttribute("name").includes("email")) {
                    fieldList[i].setAttribute("name", `booking[passengers_attributes][${dateIndex}][email]`)
                    fieldList[i].setAttribute("id", `booking_passengers_attributes_${dateIndex}_email`)
                }

                // set email input element
                if (fieldList[i].innerText == "Email") {
                    fieldList[i].setAttribute("for", `booking_passengers_attributes_${dateIndex}_email`)
                }
            }
            this.element.querySelector('.passenger-fields-container').appendChild(clone)
        }
    }

    get numPassengers() {
        return this.element.querySelectorAll("li").length
    }
}