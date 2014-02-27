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

#include "StatusFormat.h"
#include <sstream>
#include <iomanip>
#include "GccFix.h"

using namespace std;

const std::string InvalidValue("X");

std::string StatusFormat::friendlyValue(UIntN value)
{
    if (value == Constants::Invalid)
    {
        return InvalidValue;
    }
    else
    {
        return GccFix::to_string(value);
    }
}

std::string StatusFormat::friendlyValue(UInt64 value)
{
    if (value == Constants::Invalid)
    {
        return InvalidValue;
    }
    else
    {
        return GccFix::to_string(value);
    }
}

std::string StatusFormat::friendlyValue(Bool value)
{
    return (value == true) ? "true" : "false";
}

std::string StatusFormat::friendlyValue(float value)
{
    stringstream stream;
    if (value == Constants::Invalid)
    {
        stream << InvalidValue;
    }
    else
    {
        stream << setprecision(2) << fixed << value;
    }
    return stream.str();
}

std::string StatusFormat::friendlyValue(double value)
{
    stringstream stream;
    if (value == Constants::Invalid)
    {
        stream << InvalidValue;
    }
    else
    {
        stream << setprecision(2) << fixed << value;
    }
    return stream.str();
}

// TODO: remove all type specific conversions.
std::string StatusFormat::friendlyValue(ControlKnobType::Type value)
{
    string controlKnobTypeString;
    try
    {
        controlKnobTypeString = ControlKnobType::ToString(value);
    }
    catch (...)
    {
        controlKnobTypeString = InvalidValue;
    }

    return controlKnobTypeString;
}

std::string StatusFormat::friendlyValue(DomainType::Type value)
{
    string domainTypeString;
    try
    {
        domainTypeString = DomainType::ToString(value);
    }
    catch (...)
    {
        domainTypeString = InvalidValue;
    }

    return domainTypeString;
}

std::string StatusFormat::friendlyValue(LpmMode::Type type)
{
    string lpmModeString;
    try
    {
        lpmModeString = LpmMode::ToString(type);
    }
    catch (...)
    {
        lpmModeString = InvalidValue;
    }

    return lpmModeString;
}

std::string StatusFormat::friendlyValue(LpmMode::Boss boss)
{
    string lpmModeBossString;
    try
    {
        lpmModeBossString = LpmMode::ToString(boss);
    }
    catch (...)
    {
        lpmModeBossString = InvalidValue;
    }

    return lpmModeBossString;
}
