# -*- coding: utf-8 -*-

from robot.libraries.BuiltIn import BuiltIn

class Util:

    def encoding_Convert_To_UTF8_All_Variables (self):
        """ Convertit toutes les variables du projet au format UTF-8."""
        variables = BuiltIn().get_variables()
        for variable in variables:
            value = BuiltIn().get_variable_value(variable)
            if isinstance(value, str):
                # Convertit en UTF-8
                value = unicode(value, "utf-8")
                # Ajouter un \ pour les variables de type path : variables commençant par "C:\", "D:\", etc.
                if(value[:3][1:] == ":\\"):
                    value = value.replace("\\", "\\\\")
                # Repositionne les valeurs des variables
                BuiltIn().set_global_variable(variable, value)
