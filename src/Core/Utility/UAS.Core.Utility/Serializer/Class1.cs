using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;

namespace UAS.Core.Utility
{
    public class JsonSerialization
    {
        #region Attributes

        private static bool indented = false;
        private static bool privateTypes = false;
        private static bool typeName = true;
        private static bool resetConf = true;
        private static JsonSerializerSettings serializerSettings;

        #endregion

        #region Properties

        public static bool Indented { get { return indented; } set { indented = value; } }

        public static bool TypeName { get { return typeName; } set { typeName = value; } }

        public static bool PrivateTypes { get { return privateTypes; } set { privateTypes = value; } }

        #endregion

        #region Methods

        private static void Initialize()
        {
            if (serializerSettings == null)
            {
                serializerSettings = new JsonSerializerSettings();
                serializerSettings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;

                if (typeName)
                    serializerSettings.TypeNameHandling = TypeNameHandling.All;

                if (privateTypes)
                    serializerSettings.ContractResolver = new PrivateContractResolver();
            }
        }

        public static string Serialize(object objectToSerialize)
        {
            Initialize();
            return JsonConvert.SerializeObject(objectToSerialize, indented ? Formatting.Indented : Formatting.None, serializerSettings);
        }

        public static T Deserialize<T>(string objectToDeSerialize)
        {
            Initialize();
            return JsonConvert.DeserializeObject<T>(objectToDeSerialize, serializerSettings);
        }

        public static void ResetSettings()
        {
            indented = false;
            privateTypes = false;
            typeName = true;

            serializerSettings = null;
        }

        #endregion

        #region Classes

        public class PrivateContractResolver : Newtonsoft.Json.Serialization.DefaultContractResolver
        {
            protected override IList<JsonProperty> CreateProperties(Type type, MemberSerialization memberSerialization)
            {
                var props = type.GetProperties(BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Instance)
                                .Select(p => base.CreateProperty(p, memberSerialization))
                                .Union(
                                        type.GetFields(BindingFlags.Public | BindingFlags.NonPublic)
                                            .Select(f => base.CreateProperty(f, memberSerialization))
                                    ).ToList();

                props.ForEach(p => { p.Writable = true; p.Readable = true; });

                return props;
            }
        }

        #endregion
    }
}
