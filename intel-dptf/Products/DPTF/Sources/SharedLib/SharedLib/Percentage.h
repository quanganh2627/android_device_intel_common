/******************************************************************************
** Copyright (c) 2014 Intel Corporation All Rights Reserved
**
** Licensed under the Apache License, Version 2.0 (the "License"); you may not
** use this file except in compliance with the License.
**
** You may obtain a copy of the License at
**     http://www.apache.org/licenses/LICENSE-2.0
**
** Unless required by applicable law or agreed to in writing, software
** distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
** WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
**
** See the License for the specific language governing permissions and
** limitations under the License.
**
******************************************************************************/

#pragma once

#include "Dptf.h"
#include "Constants.h"

class XmlNode;

class Percentage final
{
public:

    Percentage(void);                                               // this is initialized to invalid by default
    Percentage(double percentage);                                  // 99% is stored as .99
    static Percentage fromWholeNumber(UIntN number);
    Bool isPercentageValid() const;
    Bool operator==(const Percentage& rhs) const;
    Bool operator!=(const Percentage& rhs) const;
    Bool operator>(const Percentage& rhs) const;
    Bool operator>=(const Percentage& rhs) const;
    Bool operator<(const Percentage& rhs) const;
    Bool operator<=(const Percentage& rhs) const;

    operator double(void) const;
    std::string toString() const;
    UIntN toWholeNumber() const;
    // Needed for Google Mock to print the object
    friend std::ostream& operator<<(std::ostream& os, const Percentage& percentage);

    // TODO: let's clean up the getXml() calls so that only objects that can print themselves implement it.  If an 
    // object needs information from the outside in order to print itself, then it shouldn't implement the function.
    XmlNode* getXml(void);
    XmlNode* getXml(std::string tag);

private:

    // This is in place to make sure someone doesn't try to instantiate this class with a whole number.
    Percentage(UInt64 percentage);

    static const double m_invalidPercentage;
    double m_percentage;

    Bool isPercentageValid(double percentage) const;
    void throwIfInvalidPercentage(double percentage) const;
    void throwIfInvalidPercentage(double lhs, double rhs) const;
};