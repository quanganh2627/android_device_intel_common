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

#include "Percentage.h"
#include "DptfExceptions.h"
#include "StatusFormat.h"
#include "XmlNode.h"
#include "GccFix.h"

const double Percentage::m_invalidPercentage = 9999.0;

Percentage::Percentage(void) :
    m_percentage(m_invalidPercentage)
{
}

Percentage::Percentage(double percentage) :
    m_percentage(percentage)
{
    if (isPercentageValid(percentage) == false)
    {
        throw dptf_exception("Percentage is not valid.");
    }
}

Percentage Percentage::fromWholeNumber(UIntN number)
{
    return (double)((double)number / 100.0);
}

Bool Percentage::isPercentageValid() const
{
    return isPercentageValid(m_percentage);
}

Bool Percentage::operator==(const Percentage& rhs) const
{
    return (this->m_percentage == rhs.m_percentage);
}

Bool Percentage::operator!=(const Percentage& rhs) const
{
    return !(*this == rhs);
}

Bool Percentage::operator>(const Percentage& rhs) const
{
    throwIfInvalidPercentage(this->m_percentage, rhs.m_percentage);
    return (this->m_percentage > rhs.m_percentage);
}

Bool Percentage::operator>=(const Percentage& rhs) const
{
    throwIfInvalidPercentage(this->m_percentage, rhs.m_percentage);
    return (this->m_percentage >= rhs.m_percentage);
}

Bool Percentage::operator<(const Percentage& rhs) const
{
    throwIfInvalidPercentage(this->m_percentage, rhs.m_percentage);
    return (this->m_percentage < rhs.m_percentage);
}

Bool Percentage::operator<=(const Percentage& rhs) const
{
    throwIfInvalidPercentage(this->m_percentage, rhs.m_percentage);
    return (this->m_percentage <= rhs.m_percentage);
}

Percentage::operator double(void) const
{
    return m_percentage;
}

std::ostream& operator<<(std::ostream& os, const Percentage& percentage)
{
    os << percentage.toString();
    return os;
}

std::string Percentage::toString() const
{
    return GccFix::to_string(m_percentage);
}

UIntN Percentage::toWholeNumber() const
{
    return (UIntN)(m_percentage * 100);
}

XmlNode* Percentage::getXml(void)
{
    return getXml("");
}

XmlNode* Percentage::getXml(std::string tag)
{
    return XmlNode::createDataElement(tag, StatusFormat::friendlyValue(m_percentage));
}

Bool Percentage::isPercentageValid(double percentage) const
{
    return (percentage <= 1.0);
}

void Percentage::throwIfInvalidPercentage(double percentage) const
{
    if (isPercentageValid(percentage) == false)
    {
        throw dptf_exception("Percentage is not valid.");
    }
}

void Percentage::throwIfInvalidPercentage(double lhs, double rhs) const
{
    if (isPercentageValid(lhs) == false || isPercentageValid(rhs) == false)
    {
        throw dptf_exception("Percentage is not valid.");
    }
}
