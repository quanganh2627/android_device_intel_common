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

#include "Frequency.h"
#include "DptfExceptions.h"
#include "StatusFormat.h"
#include "XmlNode.h"
#include "GccFix.h"

Frequency::Frequency(void) : m_frequency(invalidFrequency)
{
}

Frequency::Frequency(UInt64 frequency) : m_frequency(frequency)
{
}

UInt64 Frequency::getFrequency() const
{
    return m_frequency;
}

Bool Frequency::isFrequencyValid() const
{
    return (m_frequency != invalidFrequency);
}

Bool Frequency::operator==(const Frequency& rhs) const
{
    // Do not throw an exception if frequency is not valid.
    return (this->getFrequency() == rhs.getFrequency());
}

Bool Frequency::operator!=(const Frequency& rhs) const
{
    // Do not throw an exception if frequency is not valid.
    return !(*this == rhs);
}

Bool Frequency::operator>(const Frequency& rhs) const
{
    throwIfFrequencyNotValid(this->getFrequency(), rhs.getFrequency());
    return (this->getFrequency() > rhs.getFrequency());
}

Bool Frequency::operator>=(const Frequency& rhs) const
{
    throwIfFrequencyNotValid(this->getFrequency(), rhs.getFrequency());
    return (this->getFrequency() >= rhs.getFrequency());
}

Bool Frequency::operator<(const Frequency& rhs) const
{
    throwIfFrequencyNotValid(this->getFrequency(), rhs.getFrequency());
    return (this->getFrequency() < rhs.getFrequency());
}

Bool Frequency::operator<=(const Frequency& rhs) const
{
    throwIfFrequencyNotValid(this->getFrequency(), rhs.getFrequency());
    return (this->getFrequency() <= rhs.getFrequency());
}

Frequency Frequency::operator+(const Frequency& rhs) const
{
    throwIfFrequencyNotValid(this->getFrequency(), rhs.getFrequency());
    return Frequency(this->getFrequency() + rhs.getFrequency());
}

Frequency Frequency::operator-(const Frequency& rhs) const
{
    throwIfFrequencyNotValid(this->getFrequency(), rhs.getFrequency());

    if (rhs.getFrequency() > this->getFrequency())
    {
        throw dptf_exception("Invalid frequency subtraction requested.  rhs > lhs.");
    }

    return Frequency(this->getFrequency() - rhs.getFrequency());
}

Frequency Frequency::operator*(const Frequency& rhs) const
{
    throwIfFrequencyNotValid(this->getFrequency(), rhs.getFrequency());
    return Frequency(this->getFrequency() * rhs.getFrequency());
}

std::string Frequency::toString() const
{
    if (isFrequencyValid())
    {
        return GccFix::to_string(m_frequency) + "Hz";
    }
    else
    {
        return "_Hz";
    }
}

XmlNode* Frequency::getXml(std::string tag) const
{
    return XmlNode::createDataElement(tag, StatusFormat::friendlyValue(m_frequency));
}

void Frequency::throwIfFrequencyNotValid(UInt64 lhs, UInt64 rhs) const
{
    if (lhs == invalidFrequency || rhs == invalidFrequency)
    {
        throw dptf_exception("Frequency is not valid.");
    }
}
