/*
* generated by Xtext
*/
package com.github.jknack.ui.labeling

import com.google.inject.Inject
import com.github.jknack.antlr4.Options
import com.github.jknack.antlr4.Option
import com.github.jknack.antlr4.Tokens
import com.github.jknack.antlr4.V3Token
import com.github.jknack.antlr4.V4Token
import com.github.jknack.antlr4.Import
import com.github.jknack.antlr4.Imports
import com.github.jknack.antlr4.ParserRule
import com.github.jknack.antlr4.Action
import com.github.jknack.antlr4.RuleAction
import com.github.jknack.antlr4.LexerRule
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EStructuralFeature
import org.eclipse.emf.ecore.EClass
import org.eclipse.emf.ecore.EAttribute
import org.eclipse.emf.ecore.util.FeatureMap
import com.github.jknack.antlr4.RuleBlock
import com.github.jknack.antlr4.LexerRuleBlock
import com.github.jknack.antlr4.ExceptionGroup
import com.github.jknack.antlr4.TokenVocab
import com.github.jknack.antlr4.LocalVars

/**
 * Provides labels for a EObjects.
 * 
 * see http://www.eclipse.org/Xtext/documentation.html#labelProvider
 */
class Antlr4LabelProvider extends org.eclipse.xtext.ui.label.DefaultEObjectLabelProvider {

  @Inject
  new(org.eclipse.emf.edit.ui.provider.AdapterFactoryLabelProvider delegate) {
    super(delegate);
  }

  def indent(Object text) {
    "  " + text
  }

  def text(EObject object) {
    var label = labelFeature(object.eClass, "name")
    if(label == null) {
      label = labelFeature(object.eClass, "id")
    }
    if (label != null) {
      indent(object.eGet(label))
    } else {
      indent(object.eClass.name.toLowerCase)
    }
  }

  def text(Import delegate) {
    indent(" " + delegate.importURI.name)
  }

  def text(TokenVocab tokenVocab) {
    indent(" " + tokenVocab.importURI.name)
  }

  def text(Tokens tokens) {
    indent("tokens")
  }

  def text(LocalVars locals) {
    indent("locals " + locals.body)
  }

  def text(Action action) {
    if (action.scope == null) {
      indent(action.name)
    } else {
      indent(action.scope + "::" + action.name)
    }
  }

  def text(ParserRule rule) {
    var text = rule.name
    if (rule.args != null) {
      text = text + " " + rule.args
    }
    if (rule.^return != null) {
      text = text + " : "
      val values = rule.^return
          .replace("returns", "")
          .replace("[", "")
          .replace("]", "")
          .trim()
          .split("\\s+");

      if (values.length > 2) {
        text = text + "..."
      } else {
        text = text + values.get(0)
      }
    }
    indent(text)
  }

  def text(RuleBlock empty) {
    null
  }

  def text(LexerRuleBlock empty) {
    null
  }

  def text(com.github.jknack.antlr4.Exceptions empty) {
    null
  }

  def text(ExceptionGroup empty) {
    null
  }

  def image(ParserRule rule) {
    return "rule.png"
  }

  def image(Options options) {
    return "options.png"
  }

  def image(Option option) {
    return "option.png"
  }

  def image(Tokens tokens) {
    return "token.png"
  }

  def image(V3Token tokens) {
    return "token.png"
  }

  def image(V4Token tokens) {
    return "token.png"
  }

  def image(LexerRule rule) {
    if (rule.fragment) {
      return "fragment.png"
    } else {
      return "token.png"
    }
  }

  def image(Action action) {
    return "action.png"
  }

  def image(RuleAction action) {
    return "action.png"
  }

  def image(Imports imports) {
    return "imports.png"
  }

  def image(Import delegate) {
    return "import.png"
  }

  def image(TokenVocab tokenVocab) {
    return "import.png"
  }

  def image(LocalVars locals) {
    return "locals.png"
  }

  protected def EStructuralFeature labelFeature(EClass eClass, String feature) {
    var EAttribute result = null
    for (eAttribute : eClass.EAllAttributes) {
      if (!eAttribute.many && eAttribute.EType.instanceClass != FeatureMap.Entry) {
        if (feature.equalsIgnoreCase(eAttribute.getName())) {
          return eAttribute;
        } else if (result == null) {
          result = eAttribute;
        } else if (eAttribute.EAttributeType.instanceClass == String
            && result.EAttributeType.instanceClass != String) {
          result = eAttribute;
        }
      }
    }
    return result;
  }
}