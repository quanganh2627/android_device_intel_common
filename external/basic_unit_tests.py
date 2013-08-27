#!/usr/bin/env python
import glob
import os
import shutil
import subprocess
import unittest


class TestExternalPrebuiltFramework(unittest.TestCase):

    def setUp(self):
        self.env = os.environ
        self.androidTop = self.env.get("ANDROID_BUILD_TOP", None)
        if self.androidTop is None:
            self.fail("Please first source build/envsetup.sh and lunch command")
        self.productOut = self.env.get("ANDROID_PRODUCT_OUT")
        self.targetProduct = self.env.get("TARGET_PRODUCT")

    def getExpectedMakefiles(self, testPath):
        expectedMakefiles = glob.glob(os.path.join(self.androidTop,
                                                   testPath,
                                                   "expectedExternal_*.mk"))
        return expectedMakefiles

    def checkOnePath(self, testPath):
        # first rm prebuilt out folder
        prebuiltOut = os.path.join(self.productOut,
                                   "prebuilts/intel",
                                   testPath.replace("/PRIVATE/",
                                                    "/prebuilts/%s/" % (self.targetProduct,)))
        if os.path.exists(prebuiltOut):
            shutil.rmtree(prebuiltOut)

        # launch make command
        makeCommand = ("TEST_EXTERNAL_PREBUILT=true"
                       " ONE_SHOT_MAKEFILE=%s/Android.mk make -C %s"
                       " -f build/core/main.mk all_modules intel_prebuilts" % (testPath,
                                                                               self.androidTop))
        subprocess.check_call(makeCommand, shell=True, cwd=self.androidTop)
        self.assertTrue(os.path.exists(prebuiltOut))

        # Check generated files list in prebuilt out
        expectedExternalFiles = os.path.join(self.androidTop,
                                             testPath,
                                             "expectedExternalFiles.txt")
        with open(expectedExternalFiles) as f:
            expectedExternalFiles = f.readlines()
        self.assertTrue(expectedExternalFiles)
        expectedExternalFiles = [f.strip() for f in expectedExternalFiles]
        generatedFiles = glob.glob(os.path.join(prebuiltOut, "*"))
        self.assertTrue(generatedFiles)
        generatedFiles = [os.path.basename(f) for f in generatedFiles]
        self.assertEqual(set(generatedFiles), set(expectedExternalFiles))

        # Check generated Android.mk in prebuilt out
        generatedMakefile = os.path.join(prebuiltOut,
                                         "Android.mk")
        with open(generatedMakefile) as f:
            generatedMakefile = f.read()
        self.assertTrue(generatedMakefile)
        expectedMakefiles = self.getExpectedMakefiles(testPath)
        self.assertTrue(expectedMakefiles)
        for makefile in expectedMakefiles:
            with open(makefile) as f:
                content = f.read()
            self.assertIn(content, generatedMakefile, "expected:%s not exactly found"
                                                      " in generated: %s" % (content,
                                                                             generatedMakefile))

    def testExternalNominal(self):
        testPath = "vendor/intel/hardware/PRIVATE/platform_test/external/testNominal/"
        self.checkOnePath(testPath)

    def testExternalSameModuleNamePass(self):
        # shared and static livraries with same name
        testPath = "vendor/intel/hardware/PRIVATE/platform_test/external/testSameModulePass/"
        self.checkOnePath(testPath)

    def testExternalSameModuleNameFail(self):
        # shared and host libraries with same name are curerntly not supported.
        # An error must be raised by the framework
        testPath = "vendor/intel/hardware/PRIVATE/platform_test/external/testSameModuleFail/"
        try:
            self.checkOnePath(testPath)
        except Exception:
            pass
        else:
            self.fail("Test should fail")


def main():
    suite = unittest.TestLoader().loadTestsFromTestCase(TestExternalPrebuiltFramework)
    unittest.TextTestRunner(verbosity=2).run(suite)

if __name__ == "__main__":
    main()
